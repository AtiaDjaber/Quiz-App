import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:question_answear_app/dbhelper.dart';
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
  final dbHelper = DatabaseHelper.instance;

  var index = 0;
  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 2);

    getData();
    super.onInit();
  }

  getData() {
    dbHelper.queryData(tableCategories).then((res) {
      items = [];
      for (var row in res) {
        Category cli = Category.fromMap(row);
        items.add(cli);
      }
      update();
    });
  }

  void insertData() async {
    Map<String, dynamic> row = {nameCategory: nameContr.text};
    try {
      final id = await dbHelper.insert(tableCategories, row);
      print(id);
      getData();
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
}
