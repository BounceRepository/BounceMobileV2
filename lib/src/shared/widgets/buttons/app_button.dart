import 'package:bounce_patient_app/src/shared/extensions/string.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.labelColor,
    this.labelSize,
    this.backgroundColor,
    this.isLoading = false,
    this.child,
    this.elevation = 0,
    this.icon,
    this.border,
    this.padding,
    this.borderRadius,
  }) : super(key: key);

  final String label;
  final Function() onTap;
  final Color? labelColor;
  final double? labelSize;
  final Color? backgroundColor;
  final bool isLoading;
  final Widget? child;
  final double elevation;
  final String? icon;
  final BorderSide? border;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      child: InkWell(
        onTap: isLoading ? null : onTap,
        child: Container(
          height: 48.h,
          width: size.width,
          padding: padding ?? EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.primary,
            borderRadius: borderRadius ?? BorderRadius.circular(12.r),
          ),
          alignment: Alignment.center,
          child: isLoading
              ? SizedBox(
                  height: 20.w,
                  width: 20.w,
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : icon != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          label.toTitleCase,
                          style: AppText.bold700(context).copyWith(
                            color: labelColor ?? Colors.white,
                            fontSize: labelSize ?? 14.sp,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(
                          Icons.arrow_forward,
                          color: labelColor,
                          size: 15.sp,
                        ),
                      ],
                    )
                  : Text(
                      label.toTitleCase,
                      style: AppText.bold700(context).copyWith(
                        color: labelColor ?? Colors.white,
                        fontSize: labelSize ?? 14.sp,
                      ),
                    ),
        ),
      ),
    );
  }
}

class BorderAppButton extends StatelessWidget {
  const BorderAppButton({
    Key? key,
    required this.label,
    required this.labelColor,
    this.borderColor,
    required this.onTap,
  }) : super(key: key);

  final String label;
  final Color labelColor;
  final Color? borderColor;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      label: label.toTitleCase,
      labelColor: labelColor,
      backgroundColor: Colors.transparent,
      elevation: 0,
      border: BorderSide(color: borderColor ?? AppColors.border),
      onTap: onTap,
    );
  }
}
