import 'package:get/get.dart';
import 'package:question_answear_app/pages/category/data/category_respository.dart';
import 'package:question_answear_app/pages/home/presentation/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.lazyPut<CategoryRepository>(() => CategoryRepositoryImp());
  }
}
