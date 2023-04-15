import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:question_answear_app/pages/Section/data/Section_respository.dart';
import 'package:question_answear_app/pages/section/domain/section.dart';

class SectionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  String editOrAdd = "إضافة";
  List<Section> items = [];
  Section selectedSection = Section();
  TextEditingController nameContr = TextEditingController();
  TextEditingController priceContr = TextEditingController();
  TextEditingController typeCont = TextEditingController();
  final sectionRepository =
      Get.put<SectionRepository>(SectionRepositoryImp(), permanent: true);

  var index = 0;
  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 2);

    getData();
    super.onInit();
  }

  getData() async {
    // items = await sectionRepository.getData(tableSections);
    update();
  }

  void insertData() async {
    // Map<String, dynamic> row = {nameSection: nameContr.text};
    // try {
    //   final id = await dbHelper.insert(tableCategories, row);
    //   print(id);
    //   getData();
    // } catch (e) {
    //   print(e);
    // }
  }

  updateData(Section Section) async {
    Map<String, dynamic> row = {
      idSection: selectedSection.id,
      nameSection: nameContr.text,
    };

    // await dbHelper.updateService(Section.fromMap(row));
    getData();
  }
}
