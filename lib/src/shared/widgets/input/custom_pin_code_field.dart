import 'package:bounce_patient_app/src/shared/styles/colors.dart';
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
        height: 58.h,
        width: 277.w,
        child: PinCodeTextField(
          appContext: context,
          length: 4,
          obscureText: true,
          obscuringCharacter: '*', animationType: AnimationType.none,
          boxShadows: [
            BoxShadow(
              color: Colors.black.withOpacity(.12),
            ),
            const BoxShadow(
              color: Color(0xffF6F6F6),
              offset: Offset(2, 2),
              spreadRadius: 0,
              blurRadius: 4,
            ),
          ],
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(8),
            fieldHeight: 58.h,
            fieldWidth: 58.h,
            activeColor: AppColors.primary,
            inactiveColor: AppColors.textGrey,
            activeFillColor: const Color(0xffF6F6F6),
            inactiveFillColor: const Color(0xffF6F6F6),
            errorBorderColor: AppColors.error,
            selectedFillColor: Colors.transparent,
            borderWidth: 0,
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
