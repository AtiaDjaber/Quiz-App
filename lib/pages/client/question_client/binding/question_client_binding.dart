import 'package:get/get.dart';
import 'package:question_answear_app/pages/client/question_client/presentation/controllers/question_client_controller.dart';

class QuestionClientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuestionClientController());
  }
}
