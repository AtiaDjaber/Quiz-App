import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:question_answear_app/dbhelper.dart';
import 'package:question_answear_app/pages/category/presentation/views/category_view.dart';
import 'package:question_answear_app/routes/app_pages.dart';
import 'package:question_answear_app/routes/app_routes.dart';

import 'constansts.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: 'Quiz',
      getPages: AppPages.routes,
      initialRoute: AppPages.INITIAL,
      theme: ThemeData(
        fontFamily: font,
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: Colors.white),
        appBarTheme: const AppBarTheme(color: primaryColor),
        primarySwatch: Colors.blue,
      ),
    ),
  );
}
