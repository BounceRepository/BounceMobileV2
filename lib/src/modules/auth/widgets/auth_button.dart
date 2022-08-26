import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.isLoading = false,
  }) : super(key: key);

  final String label;
  final Function() onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 212.15.w,
      child: AppButton(
        label: label,
        labelColor: Colors.white,
        isLoading: isLoading,
        labelSize: 13.06.sp,
        onTap: onTap,
      ),
    );
  }
}
