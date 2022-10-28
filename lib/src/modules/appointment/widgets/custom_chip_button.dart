import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomChipButton extends StatelessWidget {
  const CustomChipButton({
    Key? key,
    required this.title,
    required this.isSelected,
    this.height,
    required this.onTap,
    this.width,
  }) : super(key: key);

  final String title;
  final bool isSelected;
  final double? height;
  final double? width;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        margin: EdgeInsets.symmetric(vertical: 6.h),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 22.5.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : const Color(0xffFEFEFE),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: AppColors.boxshadow4,
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: AppText.bold400(context).copyWith(
            fontSize: 12.sp,
            color: isSelected ? Colors.white : null,
          ),
        ),
      ),
    );
  }
}
