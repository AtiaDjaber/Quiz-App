import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:question_answear_app/constansts.dart';
import 'package:question_answear_app/pages/admin/question/domain/question.dart';
import 'package:question_answear_app/pages/admin/section/data/section_respository.dart';
import 'package:question_answear_app/pages/admin/section/domain/section.dart';
import 'package:question_answear_app/pages/admin/question/data/question_respository.dart';
import 'package:question_answear_app/pages/client/section_client/presentation/controllers/section_client_controller.dart';

class QuestionClientController extends GetxController {
  List<Question> items = [];
  Section selectedSection = Section();

  final repository = Get.put<QuestionRepository>(QuestionRepositoryImp());
  final sectionRepository = Get.put<SectionRepository>(SectionRepositoryImp());

  bool isEditingAnswer = false;
  var index = 0;
  Section? section;
  int? indexSection;
  int indexQuestion = 0;
  int questionCount = 0;
  int counter = 60;
  List<Answer> answers = [];
  Timer? countdownTimer;
  Duration myDuration = const Duration(seconds: 60);

  Answer? selectedAnswer;
  bool showResult = false;
  Map<String, double> dataMap = {};
  @override
  void onInit() {
    section = (Get.arguments as Map)["section"];
    int status = Get.arguments["status"] as int;
    getData(status).then((value) {
      if (items.isNotEmpty) {
        if (status == 1) {
          indexQuestion = section?.indexLastQuestion ?? 0;
        }
        getAnswer(items[indexQuestion].id!);
        startTimer();
      }
    });

    super.onInit();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  @override
  void onClose() {
    stopTimer();
    super.onClose();
  }

  void stopTimer() {
    countdownTimer?.cancel();
  }

  // Step 5
  void restartTimer() {
    stopTimer();
    counter = 60;
    startTimer();
    update();
  }

  void setCountDown() {
    if (counter <= 0) {
      countdownTimer?.cancel();
      selectedAnswer = answers.firstWhere((element) => element.isValid == 1);
      setAnswer(selectedAnswer!);
    } else {
      counter = counter - 1;
    }
    update();
  }

  Future getData(int argument) async {
    // if (argument == 2 || argument == 1) {
    items = await repository
        .getData(tableQuestions, "sections_id = ?", [section!.id!]);
    questionCount = items.length;
    //
    if (argument == 0) {
      items = items.where((e) => e.answered == 0).toList();
    }
    // } else {
    //   items = await repository.getData(tableQuestions,
    //       "sections_id = ? AND answered = ?", [section!.id!, argument]);
    // }

    update();
  }

  getAnswer(int questionId) async {
    selectedAnswer = null;
    answers = await repository
        .getAnswer(tableAnswers, "questions_id = ?", [questionId]);
    answers.shuffle();

    restartTimer();

    section?.indexLastQuestion = indexQuestion;
    sectionRepository
        .updateData(tableSections, section!.toMap(), [section!.id]);
  }

  FilePickerResult? result;

  Future<FilePickerResult?> getFile() async {
    return await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
  }

  updateImageQuestion(Question item) async {
    result = await getFile();
    if (result != null) {
      item.photo = result?.files.first.path;
      repository.updateData(tableQuestions, item.toMap(), [item.id]);
      update();
    }
  }

  updateImageAnswer(Answer item) async {
    result = await getFile();
    if (result != null) {
      item.name = result?.files.first.path;
      repository.updateData(tableAnswers, item.toMap(), [item.id]);
      update();
    }
  }

  double calculateProgress(int errorQuestionCount) {
    return errorQuestionCount * 100 / questionCount;
  }

  void setAnswer(Answer e) {
    if (selectedAnswer == null) {
      selectedAnswer = e;
      var item = items[indexQuestion];
      item.answered = e.isValid == 1 ? 1 : 0;

      section?.progress = 100 -
          calculateProgress(
              items.where((element) => element.answered == 0).length);
      repository.updateData(tableSections, section!.toMap(), [section?.id]);
      repository.updateData(tableQuestions, item.toMap(), [item.id]);
      if (items.length - 1 == indexQuestion) {
        showResult = true;
        dataMap = {
          "الصحيحة": items
              .where((element) => element.answered == 1)
              .toList()
              .length
              .toDouble(),
          "الخاطئة": items
              .where((element) => element.answered == 0)
              .toList()
              .length
              .toDouble()
        };
      }
      update();
      Get.find<SectionClientController>().getData();
    }
  }

  bool checkIsImage(String? name) {
    if (name != null &&
        (name.contains(".jpg") ||
            name.contains(".gif") ||
            name.contains(".tiff") ||
            name.contains(".jpeg") ||
            name.contains(".png")) &&
        !name.startsWith("http")) {
      return true;
    }
    return false;
  }
}
