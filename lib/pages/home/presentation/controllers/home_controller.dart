import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:question_answear_app/dbhelper.dart';
import 'package:question_answear_app/pages/category/data/category_respository.dart';
import 'package:question_answear_app/pages/category/domain/category.dart';

class HomeController extends GetxController {
  final categoryRepository =
      Get.put<CategoryRepository>(CategoryRepositoryImp(), permanent: true);
  int currentIndex = 0;
  List<Category> items = [];

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    items = await categoryRepository.getData(tableCategories);
    update();
  }
}
