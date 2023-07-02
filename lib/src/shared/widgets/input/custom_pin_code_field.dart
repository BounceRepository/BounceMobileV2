import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomPinCodeTextField extends StatelessWidget {
  const CustomPinCodeTextField({Key? key, required this.onChanged}) : super(key: key);

  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      width: double.infinity,
      child: PinCodeTextField(
        appContext: context,
        length: 4,
        obscureText: true,
        obscuringCharacter: '*',
        animationType: AnimationType.none,
        textStyle: AppText.bold500(context).copyWith(
          fontSize: 18.sp,
          color: AppColors.textBrown,
        ),
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(10.r),
          fieldHeight: 60.h,
          fieldWidth: 60.h,
          activeColor: AppColors.primary,
          inactiveColor: AppColors.primary,
          selectedColor: AppColors.primary,
          activeFillColor: const Color(0xffF6F6F6),
          inactiveFillColor: const Color(0xffF6F6F6),
          errorBorderColor: AppColors.error,
          selectedFillColor: Colors.transparent,
          borderWidth: 0.5.h,
          fieldOuterPadding: EdgeInsets.zero,
        ),
        keyboardType: TextInputType.number,
        onChanged: onChanged,
        validator: (value) {
          if (value!.length != 4) {
            return "";
          }
          return null;
        },
      ),
    );
  }
}
