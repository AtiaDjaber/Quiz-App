import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:question_answear_app/pages/admin/category/domain/category.dart';
import 'package:question_answear_app/pages/admin/section/data/section_respository.dart';
import 'package:question_answear_app/pages/client/home/presentation/controllers/home_controller.dart';
import 'package:question_answear_app/pages/admin/question/data/question_respository.dart';
import 'package:question_answear_app/pages/admin/question/domain/question.dart';
import 'package:question_answear_app/pages/admin/section/domain/section.dart';
import 'package:file_picker/file_picker.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

class SectionClientController extends GetxController
    with GetSingleTickerProviderStateMixin {
  List<Section> items = [];
  List<Category> categories = Get.find<HomeController>().items;
  Section selectedSection = Section();

  final sectionRepository = Get.put<SectionRepository>(SectionRepositoryImp());

  var index = 0;
  Category? category;
  int? indexCategory;

  @override
  void onInit() {
    category = Get.arguments;

    getData();
    super.onInit();
  }

  getData() async {
    items = await sectionRepository.getData(category!.id!);
    update();
  }
}
