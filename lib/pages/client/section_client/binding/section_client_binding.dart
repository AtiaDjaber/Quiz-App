import 'package:get/get.dart';
import 'package:question_answear_app/pages/client/section_client/presentation/controllers/section_client_controller.dart';

class SectionClientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SectionClientController());
  }
}
