import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:question_answear_app/core/widget/custom_elevated_button.dart';

showDeleteDialog() async {
  return await Get.dialog(Directionality(
    textDirection: TextDirection.rtl,
    child: AlertDialog(
      title: Text("هل انت متاكد من الحذف ؟"),
      actions: [
        CustomElevatedButton(
          title: "موافق",
          onPressed: () => Get.back(result: true),
        ),
        CustomElevatedButton(
          title: "إلغاء",
          backgroundColor: Colors.grey.shade300,
          foregroundColor: Colors.grey.shade800,
          onPressed: () => Get.back(result: false),
        )
      ],
    ),
  ));
}
