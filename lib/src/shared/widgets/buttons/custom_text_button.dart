import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.padding,
    this.backgroundColor,
    this.labelColor,
    this.borderRadius,
  }) : super(key: key);

  final String label;
  final Function() onTap;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? labelColor;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: AppColors.primary.withOpacity(0.2),
        child: Container(
          padding: padding ?? EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(5.r),
            color: backgroundColor,
          ),
          child: Text(
            label,
            style: AppText.bold700(context).copyWith(
              color: labelColor ?? AppColors.primary,
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
    );
  }
}
