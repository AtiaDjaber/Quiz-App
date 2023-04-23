import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:question_answear_app/constansts.dart';
import 'package:question_answear_app/pages/admin/question/domain/question.dart';
import 'package:question_answear_app/pages/admin/section/domain/section.dart';
import 'package:question_answear_app/pages/admin/question/data/question_respository.dart';

class QuestionClientController extends GetxController {
  List<Question> items = [];
  Section selectedSection = Section();

  final repository = Get.put<QuestionRepository>(QuestionRepositoryImp());

  // File? photo;
  var index = 0;
  Section? section;
  int? indexSection;
  int indexQuestion = 0;
  int position = 1;

  int counter = 60;
  List<Answer> answers = [];
  Timer? countdownTimer;
  Duration myDuration = const Duration(seconds: 60);

  Answer? selectedAnswer;

  @override
  void onInit() {
    section = (Get.arguments as Map)["section"];

    position = indexQuestion + 1;
    getData(Get.arguments["status"] as int).then((value) {
      if (items.isNotEmpty) {
        getAnswer(items[0].id!);
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
      countdownTimer!.cancel();
      selectedAnswer = answers.firstWhere((element) => element.isValid == 1);
      var item = items[indexQuestion];
      item.answered = 0;
      repository.updateData(tableQuestions, item.toMap(), [item.id]);
      update();
    } else {
      counter = counter - 1;
    }
    update();
  }

  Future getData(int argument) async {
    items = await repository.getData(tableQuestions,
        "sections_id = ? AND answered = ?", [section!.id!, argument]);
    update();
  }

  getAnswer(int questionId) async {
    selectedAnswer = null;
    answers = await repository
        .getAnswer(tableAnswers, "questions_id = ?", [questionId]);
    answers.shuffle();
    restartTimer();
  }

  updateImage(Question item) async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);

    if (result != null) {
      item.photo = result.files.first.path;
      repository.updateData(tableQuestions, item.toMap(), [item.id]);
      // photo = File(result.files.first.path!);

      update();
    }
  }

  getBorder(e) {
    return selectedAnswer != null
        ? (e.isValid == 1
            ? Border.all(color: primaryColor, width: 1.2)
            : selectedAnswer?.id == e.id
                ? Border.all(color: Colors.red, width: 1.2)
                : Border.all(color: Colors.grey.shade300, width: 1.2))
        : Border.all(color: Colors.grey.shade300, width: 1.2);
  }

  getIcon(e) {
    return selectedAnswer != null
        ? (e.isValid == 1
            ? const Icon(Icons.check_circle, color: primaryColor)
            : selectedAnswer?.id == e.id
                ? const Icon(Icons.cancel, color: Colors.red)
                : Icon(Icons.circle_outlined, color: Colors.grey.shade300))
        : Icon(Icons.circle_outlined, color: Colors.grey.shade300);
  }

  void setAnswer(Answer e) {
    if (selectedAnswer == null) {
      selectedAnswer = e;
      var item = items[indexQuestion];
      item.answered = e.isValid == 1 ? 1 : 0;
      repository.updateData(tableQuestions, item.toMap(), [item.id]);
      update();
    }
  }
}
