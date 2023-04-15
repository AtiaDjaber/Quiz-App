import 'package:get/get.dart';
import 'package:question_answear_app/pages/admin/question/presentation/controllers/question_controller.dart';

class QuestionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuestionController());
  }
}
