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
    return Material(
      child: SizedBox(
        height: 60.h,
        width: double.infinity,
        child: PinCodeTextField(
          appContext: context,
          length: 4,
          obscureText: true,
          obscuringCharacter: '*', animationType: AnimationType.none,
          // boxShadows: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(.12),
          //   ),
          //   const BoxShadow(
          //     color: Color(0xffF6F6F6),
          //     offset: Offset(2, 2),
          //     spreadRadius: 0,
          //     blurRadius: 4,
          //   ),
          // ],
          textStyle: AppText.bold500(context).copyWith(
            fontSize: 18.sp,
            color: AppColors.textBrown,
          ),
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(10.r),
            fieldHeight: 60.h,
            fieldWidth: 60.h,
            activeColor: const Color(0xffFCE7D8),
            inactiveColor: const Color(0xffFCE7D8),
            selectedColor: const Color(0xffFCE7D8),
            activeFillColor: const Color(0xffF6F6F6),
            inactiveFillColor: const Color(0xffF6F6F6),
            errorBorderColor: AppColors.error,
            selectedFillColor: Colors.transparent,
            borderWidth: 0,
            fieldOuterPadding: EdgeInsets.zero,
          ),
          //  animationDuration: const Duration(milliseconds: 300),
          keyboardType: TextInputType.number,

          //  enableActiveFill: true,
          onChanged: onChanged,

          validator: (value) {
            if (value!.length != 4) {
              return "";
            }
            return null;
          },
          // onCompleted: (value) async {
          //   // authViewModel.createUnVerifiedUserInfo(
          //   //   email: widget.email,
          //   //   token: token,
          //   // );
          // },
          // beforeTextPaste: (text) {
          //   //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
          //   //but you can show anything you want here, like your pop up saying wrong paste format or etc
          //   return true;
          // },
        ),
      ),
    );
  }
}
