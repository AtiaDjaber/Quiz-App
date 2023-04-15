import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:question_answear_app/pages/admin/category/domain/category.dart';
import 'package:question_answear_app/pages/admin/section/domain/section.dart';
import 'package:question_answear_app/pages/client/home/presentation/controllers/home_controller.dart';
import 'package:question_answear_app/pages/admin/question/domain/question.dart';
import 'package:file_picker/file_picker.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

import '../../data/question_respository.dart';

class QuestionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  String editOrAdd = "إضافة";
  List<Question> items = [];
  List<Category> categories = Get.find<HomeController>().items;
  Question selectedQuestion = Question();
  TextEditingController nameContr = TextEditingController();
  TextEditingController priceContr = TextEditingController();
  TextEditingController typeCont = TextEditingController();
  final questionRepository =
      Get.put<QuestionRepository>(QuestionRepositoryImp(), permanent: true);

  var index = 0;
  Section? section;
  int? indexCategory;

  @override
  void onInit() {
    section = Get.arguments;
    tabController = TabController(vsync: this, length: 2);

    getData();
    super.onInit();
  }

  getData() async {
    items = await questionRepository
        .getData(tableQuestions, "sections_id = ?", [section!.id!]);
    update();
  }

  void insertData() async {
    selectedQuestion.name = nameContr.text;
    selectedQuestion.sectionId = 1;
    try {
      final id = await questionRepository.insert(
          tableQuestions, selectedQuestion.toMap());
      print(id);
      getData();
    } catch (e) {
      print(e);
    }
  }

  updateData(Question section) async {
    Map<String, dynamic> row = {
      idQuestion: selectedQuestion.id,
      nameQuestion: nameContr.text,
    };

    // await dbHelper.updateService(Question.fromMap(row));
    getData();
  }

  Future<void> uploadFile(Question section) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
        allowMultiple: false);

    if (result != null) {
      File file = File(result.files.single.path!);
      var bytes = await file.readAsBytes();
      if (bytes != null) {
        var decoder = SpreadsheetDecoder.decodeBytes(bytes);
        for (var table in decoder.tables.keys) {
          for (var row in decoder.tables[table]!.rows) {
            print(row[0]);
          }
        }
        // var excel = Excel.decodeBytes(bytes);

      }
    } else {
      // User canceled the picker
    }
  }
}
