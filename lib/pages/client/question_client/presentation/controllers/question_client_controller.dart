import 'dart:io';
import 'package:get/get.dart';
import 'package:question_answear_app/pages/admin/question/domain/question.dart';
import 'package:question_answear_app/pages/admin/section/domain/section.dart';
import 'package:question_answear_app/pages/admin/question/data/question_respository.dart';
import 'package:question_answear_app/pages/admin/section/data/section_respository.dart';
import 'package:question_answear_app/pages/client/home/presentation/controllers/home_controller.dart';
import 'package:question_answear_app/pages/admin/section/domain/section.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

class QuestionClientController extends GetxController {
  List<Question> items = [];
  Section selectedSection = Section();

  final repository = Get.put<QuestionRepository>(QuestionRepositoryImp());

  var index = 0;
  Section? section;
  int? indexsection;
  int indexQuestion = 1;
  int position = 1;

  List<Answer> answers = [];
  @override
  void onInit() {
    section = Get.arguments;
    position = indexQuestion + 1;
    getData();
    super.onInit();
  }

  getData() async {
    items = await repository
        .getData(tableQuestions, "sections_id = ?", [section!.id!]);
    update();
  }

  getAnswer(int questionId) async {
    answers = await repository
        .getAnswer(tableAnswers, "questions_id = ?", [questionId]);
    answers.shuffle();
    update();
  }
}
