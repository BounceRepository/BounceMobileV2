import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class NotificationMessage {
  static show(
    BuildContext context, {
    required String message,
  }) {
    snackBar(
      context,
      child: CustomSnackBar.info(message: message),
    );
  }

  static showError(
    BuildContext context, {
    required String message,
  }) {
    snackBar(
      context,
      child: CustomSnackBar.error(message: message),
    );
  }

  static showSucess(
    BuildContext context, {
    required String message,
  }) {
    snackBar(
      context,
      child: CustomSnackBar.success(message: message),
    );
  }

  static snackBar(BuildContext context, {required Widget child}) {
    showTopSnackBar(context, child);
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
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Message',
            style: textStyle.copyWith(
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            message,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
