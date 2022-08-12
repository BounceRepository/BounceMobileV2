import 'package:bounce_patient_app/src/modules/auth/screens/reset_password_screen.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/auth_button.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/link_text.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/input/custom_pin_code_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //SizedBox(height: 83.79.h),
                SvgPicture.asset(
                  AuthIcons.otp,
                  width: 236.02.w,
                  height: 283.01.h,
                ),
                SizedBox(height: 22.99.h),
                Text(
                  'OTP VERIFICATION',
                  style: AppText.bold500(context).copyWith(
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(height: 17.h),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Enter the OTP sent to ',
                    style: AppText.bold400(context).copyWith(
                      fontSize: 14.sp,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'bouncemail@yahoo.com',
                        style: AppText.bold600(context).copyWith(
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 21.h),
                CustomPinCodeTextField(
                  onChanged: (value) {},
                ),
                SizedBox(height: 26.h),
                Text(
                  '00:60 ',
                  style: AppText.bold500(context).copyWith(
                    fontSize: 14.sp,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 26.h),
                LinkText(
                  text1: 'Didn’t receive code?',
                  text2: 'Re-send',
                  onClick: () {},
                ),
                SizedBox(height: 38.h),
                AuthButton(
                  label: 'Submit',
                  onTap: () {
                    AppNavigator.to(context, const ResetPasswordScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
