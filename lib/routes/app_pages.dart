import 'package:get/get.dart';
import 'package:question_answear_app/pages/category/binding/category_binding.dart';
import 'package:question_answear_app/pages/category/presentation/views/category_view.dart';
import 'package:question_answear_app/pages/home/binding/home_binding.dart';
import 'package:question_answear_app/pages/home/presentation/views/home_view.dart';
import 'package:question_answear_app/pages/section/binding/section_binding.dart';
import 'package:question_answear_app/pages/section/presentation/views/section_view.dart';

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
  ];
}
