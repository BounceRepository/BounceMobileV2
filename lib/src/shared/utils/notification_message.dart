import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationMessage {
  static TextStyle textStyle(BuildContext context) {
    return AppText.bold500(context).copyWith(
      color: Colors.white,
    );
  }

  static EdgeInsetsGeometry margin() {
    return EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h);
  }

  static show(
    BuildContext context, {
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        margin: margin(),
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: textStyle(context),
        ),
      ),
    );
  }

  static showError(
    BuildContext context, {
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        margin: margin(),
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: textStyle(context),
        ),
      ),
    );
  }

  static showSucess(
    BuildContext context, {
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        margin: margin(),
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: textStyle(context),
        ),
      ),
    );
  }
}
