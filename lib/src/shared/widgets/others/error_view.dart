import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/extensions/string.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
    required this.error,
    required this.retry,
    this.height,
    this.textColor,
  });

  final Failure error;
  final Function() retry;
  final double? height;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.symetricHorizontalOnly,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppIcons.error,
            width: 256.w,
            height: height ?? 212.h,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20.h),
          Text(
            'Error!',
            style: AppText.bold700(context).copyWith(
              fontSize: 20.sp,
              color: textColor,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            error.message.toTitleCase,
            textAlign: TextAlign.center,
            style: AppText.bold300(context).copyWith(
              fontSize: 14.sp,
              color: textColor,
            ),
          ),
          SizedBox(height: 64.h),
          BorderAppButton(
            label: 'Try Again',
            labelColor: AppColors.primary,
            borderColor: AppColors.primary,
            onTap: retry,
          ),
        ],
      ),
    );
  }
}

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    required this.error,
    required this.retry,
    this.iconHeight,
    this.iconWidth,
  });

  final Failure error;
  final Function() retry;
  final double? iconHeight;
  final double? iconWidth;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20.h),
          SvgPicture.asset(
            AppIcons.error,
            width: iconWidth ?? 200.w,
            height: iconHeight ?? 150.h,
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
            error.message.toTitleCase,
            textAlign: TextAlign.center,
            style: AppText.bold300(context).copyWith(
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: 200.w,
            child: BorderAppButton(
              label: 'Try Again',
              labelColor: AppColors.primary,
              borderColor: AppColors.primary,
              onTap: retry,
            ),
          ),
        ],
      ),
    );
  }
}
