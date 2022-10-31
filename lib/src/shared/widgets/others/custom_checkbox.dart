import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
    super.key,
    this.size,
    required this.value,
    this.onChanged,
  });

  final double? size;
  final bool value;
  final Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? 16.h,
      width: size ?? 16.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        border: value == true ? null : Border.all(color: const Color(0xff292D32)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.r),
        child: Checkbox(
          value: value,
          activeColor: AppColors.primary,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
