import 'package:flutter/material.dart';
import 'package:question_answear_app/constansts.dart';

getBorder(e, selectedAnswer) {
  return selectedAnswer != null
      ? (e.isValid == 1
          ? Border.all(color: Colors.green, width: 1.2)
          : selectedAnswer?.id == e.id
              ? Border.all(color: Colors.red, width: 1.2)
              : Border.all(color: Colors.grey.shade300, width: 1.2))
      : Border.all(color: Colors.grey.shade300, width: 1.2);
}

getIcon(e, selectedAnswer) {
  return selectedAnswer != null
      ? (e.isValid == 1
          ? const Icon(Icons.check_circle, color: Colors.green)
          : selectedAnswer?.id == e.id
              ? const Icon(Icons.cancel, color: Colors.red)
              : Icon(Icons.circle_outlined, color: Colors.grey.shade300))
      : Icon(Icons.circle_outlined, color: Colors.grey.shade300);
}
