import 'package:get/get.dart';
import 'package:question_answear_app/pages/category/data/category_respository.dart';
import 'package:question_answear_app/pages/category/presentation/controllers/category_controller.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryController());
  }
}
