import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Messenger {
  static show(
    BuildContext context, {
    required String message,
  }) {
    _snackBar(
      context,
      child: CustomSnackBar.info(message: message),
    );
  }

  static showError(
    BuildContext context, {
    required String message,
  }) {
    _snackBar(
      context,
      child: CustomSnackBar.error(message: message),
    );
  }

  static showSucess(
    BuildContext context, {
    required String message,
  }) {
    _snackBar(
      context,
      child: CustomSnackBar.success(message: message),
    );
  }

  static _snackBar(BuildContext context, {required Widget child}) {
    showTopSnackBar(
      context,
      child,
      padding: EdgeInsets.zero,
      // persistent: true,
    );
  }
}

class CustomSnackBar extends StatelessWidget {
  final String message;
  final Color backgroundColor;

  const CustomSnackBar.success({
    Key? key,
    required this.message,
    this.backgroundColor = Colors.green,
  }) : super(key: key);

  const CustomSnackBar.error({
    Key? key,
    required this.message,
    this.backgroundColor = AppColors.error,
  }) : super(key: key);

  const CustomSnackBar.info({
    Key? key,
    required this.message,
    this.backgroundColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = AppText.bold500(context).copyWith(
      color: Colors.white,
      fontSize: 15.sp,
    );

    return Container(
      clipBehavior: Clip.hardEdge,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: DefaultTextStyle(
        style: textStyle,
        child: Text(
          message,
          style: textStyle,
        ),
      ),
    );
  }
}
