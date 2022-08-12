import 'package:bounce_patient_app/src/modules/auth/screens/forgot_password_screen.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/sign_up_screen.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/social_auth_view.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/auth_body.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/auth_button.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/link_text.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/input/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthBody(
      children: [
        Text(
          'Welcome Back!',
          style: AppText.bold600(context).copyWith(
            fontSize: 32.sp,
          ),
        ),
        SizedBox(height: 16.h),
        SvgPicture.asset(
          AuthIcons.welcome,
          width: 159.53.w,
          height: 182.h,
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
        SizedBox(height: 22.h),
        LinkText(
          text1: 'Forgot Password?',
          text2: 'Click Here',
          onClick: () {
            AppNavigator.to(context, const ForgotPasswordScreen());
          },
        ),
        SizedBox(height: 19.h),
        AuthButton(
          label: 'Sign In',
          onTap: () {},
        ),
        SizedBox(height: 39.h),
        const SocialAuthView(),
        SizedBox(height: 39.h),
        LinkText(
          text1: 'Don’t have an account?',
          text2: 'Sign Up',
          onClick: () {
            AppNavigator.to(context, const SignUpScreen());
          },
        ),
      ],
    );
  }
}
