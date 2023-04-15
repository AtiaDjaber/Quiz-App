import 'package:get/get.dart';
import 'package:question_answear_app/pages/admin/category/data/category_respository.dart';
import 'package:question_answear_app/pages/client/home/presentation/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.lazyPut<CategoryRepository>(() => CategoryRepositoryImp());
  }
}
