import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:question_answear_app/constansts.dart';
import 'package:question_answear_app/routes/app_pages.dart';

void main() {
  MaterialColor mainAppColor = const MaterialColor(0xFF89cfbe, <int, Color>{
    50: Color(0xFF89cfbe),
    100: Color(0xFF89cfbe),
    200: Color(0xFF89cfbe),
    300: Color(0xFF89cfbe),
    400: Color(0xFF89cfbe),
    500: Color(0xFF89cfbe),
    600: Color(0xFF89cfbe),
    700: Color(0xFF89cfbe),
    800: Color(0xFF89cfbe),
    900: Color(0xFF89cfbe),
  });
  runApp(
    GetMaterialApp(
      title: 'Quiz',
      getPages: AppPages.routes,
      initialRoute: AppPages.INITIAL,
      theme: ThemeData(
        fontFamily: font,
        buttonTheme: ButtonThemeData(buttonColor: primaryColor),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(primaryColor))),
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: Colors.white),
        appBarTheme: const AppBarTheme(color: primaryColor),
        primarySwatch: Colors.purple,
      ),
    ),
  );
}
