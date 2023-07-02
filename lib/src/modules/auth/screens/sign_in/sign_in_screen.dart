import 'package:bounce_patient_app/src/modules/auth/screens/sign_up/create_profile/create_profile_screen.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/forgot_password/forgot_password_screen.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/sign_up/confirmation/sign_up_confirmation_screen.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/sign_in/sign_in_controller.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/sign_up/sign_up_screen.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/sign_in/components/social_auth_view.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/auth_body.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/auth_button.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/link_text.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/password_textfield.dart';
import 'package:bounce_patient_app/src/modules/dashboard/screens/select_mood_screen.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/utils/validator.dart';
import 'package:bounce_patient_app/src/shared/models/app_session.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/models/user.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/utils/messenger.dart';
import 'package:bounce_patient_app/src/shared/widgets/input/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        await context.read<SignInController>().execute(
              username: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            );

        if (mounted) {
          Messenger.success(message: 'Login successful');

          AppNavigator.to(context, const SelectMoodsScreen());
        }
      } on Failure catch (e) {
        final user = AppSession.user;

        if (user != null) {
          if (e is InCompleteProfileFailure) {
            AppNavigator.to(
              context,
              CreateProfileScreen(
                email: user.email,
                userName: user.userName,
                nextScreen: const SelectMoodsScreen(),
              ),
            );
            return;
          }

          if (e is ConfirmEmailFailure) {
            verifyEmail(user);
            return;
          }
        }
        Messenger.error(message: e.message);
      }
    }
  }

  void verifyEmail(User user) async {
    try {
      await context.read<SignInController>().verifyEmail(email: user.email);

      if (mounted) {
        AppNavigator.to(
          context,
          SignUpConfirmationScreen(
            email: user.email,
            userName: user.userName,
            nextScreen: const SelectMoodsScreen(),
          ),
        );
      }
    } on Failure catch (e) {
      Messenger.error(message: e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Form(
        key: _formKey,
        child: AuthBody(
          children: [
            Text(
              'Welcome Back!',
              style: AppText.bold700(context).copyWith(
                fontSize: 24.sp,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 74.h),
            SvgPicture.asset(
              AuthIcons.welcome,
              width: 159.53.w,
              height: 182.h,
            ),
            SizedBox(height: 16.h),
            CustomTextField(
              controller: _emailController,
              lableText: 'Email',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (Validator.isNotValidEmail(value)) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            PasswordTextField(
              controller: _passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
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
            Consumer<SignInController>(
              builder: (context, controller, _) {
                return AuthButton(
                  label: 'Sign In',
                  isLoading: controller.isBusy,
                  onTap: submit,
                );
              },
            ),
            SizedBox(height: 39.h),
            const SocialAuthView(),
            SizedBox(height: 39.h),
            LinkText(
              text1: 'Don’t have an account?',
              text2: 'Sign Up',
              fontSize: 12.sp,
              onClick: () {
                AppNavigator.to(context, const SignUpScreen());
              },
            ),
            SizedBox(height: 39.h),
          ],
        ),
      ),
    );
  }
}