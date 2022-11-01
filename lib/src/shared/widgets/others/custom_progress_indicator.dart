import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    super.key,
    required this.value,
  });

  final double value;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24.r),
      child: LinearProgressIndicator(
        value: value,
        minHeight: 8.h,
        color: AppColors.primary,
        backgroundColor: AppColors.grey6,
      ),
    );
  }
}
