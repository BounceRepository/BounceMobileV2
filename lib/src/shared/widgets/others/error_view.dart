import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.error, required this.retry});

  final Failure error;
  final Function() retry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppIcons.error,
            width: 256.w,
            height: 212.h,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20.h),
          Text(
            'Error!',
            style: AppText.bold700(context).copyWith(
              fontSize: 20.sp,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            error.message,
            textAlign: TextAlign.center,
            style: AppText.bold300(context).copyWith(
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 64.h),
          AppButton(
            label: 'Try Again',
            labelColor: AppColors.primary,
            border: BorderSide(color: AppColors.primary, width: 2.h),
            backgroundColor: Colors.transparent,
            onTap: retry,
          ),
        ],
      ),
    );
  }
}