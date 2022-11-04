import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Messenger {
  static info({
    String? title,
    required String message,
  }) {
    Get.snackbar(
      title ?? 'Message',
      message,
      colorText: Colors.white,
      backgroundColor: Colors.black,
      barBlur: 10,
    );
  }

  static error({
    required String message,
  }) {
    Get.snackbar(
      'Failed',
      message,
      backgroundColor: AppColors.error,
      colorText: Colors.white,
      barBlur: 10,
    );
  }

  static success({
    required String message,
  }) {
    Get.snackbar(
      'Success',
      message,
      backgroundColor: AppColors.success,
      colorText: Colors.white,
      barBlur: 10,
    );
  }
}
