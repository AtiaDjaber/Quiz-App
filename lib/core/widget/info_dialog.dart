import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:question_answear_app/core/widget/custom_elevated_button.dart';

showInfoDialog() async {
  return await Get.dialog(Directionality(
    textDirection: TextDirection.rtl,
    child: AlertDialog(
      title: Text("تمت العملية بنجاح"),
      actions: [
        CustomElevatedButton(
          title: "موافق",
          onPressed: () => Get.back(result: true),
        ),
      ],
    ),
  ));
}
