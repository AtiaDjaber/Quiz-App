import 'package:get/get.dart';
import 'package:question_answear_app/pages/section/presentation/controllers/section_controller.dart';

class SectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SectionController());
  }
}
