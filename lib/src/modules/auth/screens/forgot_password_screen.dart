import 'package:bounce_patient_app/src/modules/auth/screens/otp_screen.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/auth_button.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/custom_text_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/input/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: AppPadding.symetricHorizontalOnly,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: ArrowBackButton(
                    onTap: () {},
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Forgot password?',
                  style: AppText.bold800(context).copyWith(
                    fontSize: 36.sp,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 30.h),
                RichText(
                  text: TextSpan(
                    text: '*',
                    style: AppText.bold400(context).copyWith(
                      fontSize: 12.sp,
                      color: AppColors.primary,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            ' We will send you an email to set or reset your new password',
                        style: AppText.bold400(context).copyWith(
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                SvgPicture.asset(
                  AuthIcons.forgotPassword,
                  width: 190.w,
                  height: 201.h,
                ),
                SizedBox(height: 28.h),
                CustomTextField(
                  controller: TextEditingController(),
                  hintText: 'Enter your email address',
                  prefixIcon: const TextFieldSvgIcon(icon: AppIcons.mail),
                ),
                SizedBox(height: 30.h),
                SizedBox(
                  width: 243.w,
                  child: Text(
                    'Didn’t get any email? Check your spam folder or try again with a valid email.',
                    textAlign: TextAlign.center,
                    style: AppText.bold400(context).copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                SizedBox(height: 27.h),
                AuthButton(
                  label: 'Open Email App',
                  onTap: () {},
                ),
                SizedBox(height: 10.h),
                CustomTextButton(
                  label: 'Skip',
                  onTap: () {
                    AppNavigator.to(context, const OTPScreen());
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

class ArrowBackButton extends StatelessWidget {
  const ArrowBackButton({Key? key, required this.onTap}) : super(key: key);

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 51.h,
      width: 51.h,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        AppIcons.backBrokenArrow,
        height: 14.h,
        width: 14.h,
      ),
    );
  }
}
