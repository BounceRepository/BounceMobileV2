import 'package:bounce_patient_app/src/modules/auth/screens/create_profile_screen.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/sign_in_screen.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/social_auth_view.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/auth_body.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/auth_button.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/link_text.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/input/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthBody(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            'Create Account',
            style: AppText.bold600(context).copyWith(
              fontSize: 32.sp,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        SvgPicture.asset(
          AuthIcons.createAccount,
          width: 159.53.w,
          height: 182.h,
        ),
        SizedBox(height: 16.h),
        CustomTextField(
          controller: TextEditingController(),
          lableText: 'Full Name',
        ),
        SizedBox(height: 16.h),
        CustomTextField(
          controller: TextEditingController(),
          lableText: 'Email',
        ),
        SizedBox(height: 16.h),
        CustomTextField(
          controller: TextEditingController(),
          lableText: 'Password',
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 16.h,
              width: 16.h,
              child: Checkbox(
                value: true,
                activeColor: AppColors.primary,
                onChanged: (value) {},
              ),
            ),
            SizedBox(width: 5.w),
            LinkText(
              text1: 'I agree to the BOUNCE',
              text2: 'Terms and Conditions',
              onClick: () {},
            ),
          ],
        ),
        SizedBox(height: 28.h),
        AuthButton(
          label: 'Sign Up',
          onTap: () {
            AppNavigator.to(context, const CreateProfileScreen());
          },
        ),
        SizedBox(height: 23.h),
        const SocialAuthView(),
        SizedBox(height: 23.h),
        LinkText(
          text1: 'Already have an account?',
          text2: 'Sign In',
          onClick: () {
            AppNavigator.to(context, const SignInScreen());
          },
        ),
        SizedBox(height: 51.h),
      ],
    );
  }
}
