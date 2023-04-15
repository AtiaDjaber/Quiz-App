import 'package:get/get.dart';
import 'package:question_answear_app/pages/admin/category/binding/category_binding.dart';
import 'package:question_answear_app/pages/admin/category/presentation/views/category_view.dart';
import 'package:question_answear_app/pages/client/home/binding/home_binding.dart';
import 'package:question_answear_app/pages/client/home/presentation/views/home_view.dart';
import 'package:question_answear_app/pages/admin/question/binding/question_binding.dart';
import 'package:question_answear_app/pages/admin/question/presentation/views/question_view.dart';
import 'package:question_answear_app/pages/admin/section/binding/section_binding.dart';
import 'package:question_answear_app/pages/admin/section/presentation/views/section_view.dart';
import 'package:question_answear_app/pages/client/question_client/binding/question_client_binding.dart';
import 'package:question_answear_app/pages/client/question_client/presentation/views/question_client_view.dart';
import 'package:question_answear_app/pages/client/section_client/binding/section_client_binding.dart';
import 'package:question_answear_app/pages/client/section_client/presentation/views/section_client_view.dart';

import 'app_routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.home;

  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      bindings: [HomeBinding(), CategoryBinding()],
    ),
    GetPage(
      name: AppRoutes.categories,
      page: () => const CategoryView(),
      bindings: [CategoryBinding()],
    ),
    GetPage(
      name: AppRoutes.section,
      page: () => const SectionView(),
      bindings: [SectionBinding()],
    ),
    GetPage(
      name: AppRoutes.sectionClient,
      page: () => const SectionClientView(),
      bindings: [SectionClientBinding()],
    ),
    GetPage(
      name: AppRoutes.question,
      page: () => const QuestionView(),
      bindings: [QuestionBinding()],
    ),
    GetPage(
      name: AppRoutes.questionClient,
      page: () => const QuestionClientView(),
      bindings: [QuestionClientBinding()],
    ),
  ];
}
