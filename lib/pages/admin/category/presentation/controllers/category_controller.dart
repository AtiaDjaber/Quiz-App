import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:question_answear_app/core/widget/delete_dialog.dart';
import 'package:question_answear_app/core/widget/info_dialog.dart';
import 'package:question_answear_app/dbhelper.dart';
import 'package:question_answear_app/pages/admin/category/data/category_respository.dart';
import 'package:question_answear_app/pages/client/home/presentation/controllers/home_controller.dart';
import '../../domain/category.dart';

class CategoryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  String editOrAdd = "إضافة";
  List<Category> items = [];
  Category selectedCategory = Category();
  TextEditingController nameContr = TextEditingController();
  TextEditingController priceContr = TextEditingController();
  TextEditingController typeCont = TextEditingController();
  final categoryRepository =
      Get.put<CategoryRepository>(CategoryRepositoryImp(), permanent: true);
  final dbHelper = DatabaseHelper.instance;

  HomeController homeController = Get.find<HomeController>();

  var index = 0;
  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 2);

    getData();
    super.onInit();
  }

  getData() async {
    items = await categoryRepository.getData(tableCategories);
    update();
  }

  void insertData() async {
    Map<String, dynamic> row = {nameCategory: nameContr.text};
    try {
      final id = await categoryRepository.insert(tableCategories, row);
      getData();
      showInfoDialog();
      if (homeController != null) {
        homeController.getData();
      }
    } catch (e) {
      print(e);
    }
  }

  updateData(Category category) async {
    Map<String, dynamic> row = {
      idCategory: selectedCategory.id,
      nameCategory: nameContr.text,
    };

    // await dbHelper.updateService(Category.fromMap(row));
    getData();
  }

  Future<void> delete(int? id) async {
    if (await showDeleteDialog()) {
      dbHelper.delete(tableCategories, id!);

      getData();
      if (homeController != null) {
        homeController.getData();
      }
    }
  }
}
