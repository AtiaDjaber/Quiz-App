import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:question_answear_app/pages/Section/data/Section_respository.dart';
import 'package:question_answear_app/pages/category/domain/category.dart';
import 'package:question_answear_app/pages/home/presentation/controllers/home_controller.dart';
import 'package:question_answear_app/pages/section/domain/section.dart';
import 'package:file_picker/file_picker.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

class SectionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  String editOrAdd = "إضافة";
  List<Section> items = [];
  List<Category> categories = Get.find<HomeController>().items;
  Section selectedSection = Section();
  TextEditingController nameContr = TextEditingController();
  TextEditingController priceContr = TextEditingController();
  TextEditingController typeCont = TextEditingController();
  final sectionRepository =
      Get.put<SectionRepository>(SectionRepositoryImp(), permanent: true);

  var index = 0;
  Category? category;
  int? indexCategory;

  @override
  void onInit() {
    category = Get.arguments;
    tabController = TabController(vsync: this, length: 2);

    getData();
    super.onInit();
  }

  getData() async {
    items = await sectionRepository.getData(category!.id!);
    update();
  }

  void insertData() async {
    Map<String, dynamic> row = {nameSection: nameContr.text};
    selectedSection.name = nameContr.text;
    selectedSection.progress = 0;
    try {
      final id = await sectionRepository.insert(selectedSection.toMap());
      print(id);
      getData();
    } catch (e) {
      print(e);
    }
  }

  updateData(Section section) async {
    Map<String, dynamic> row = {
      idSection: selectedSection.id,
      nameSection: nameContr.text,
    };

    // await dbHelper.updateService(Section.fromMap(row));
    getData();
  }

  Future<void> uploadFile(Section section) async {
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
