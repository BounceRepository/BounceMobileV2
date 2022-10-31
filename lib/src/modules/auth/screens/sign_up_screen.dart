import 'package:bounce_patient_app/src/modules/auth/controllers/auth_controller.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/registration_success_screens.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/sign_in_screen.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/social_auth_view.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/auth_body.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/auth_button.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/link_text.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/password_textfield.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/helper_functions/validator.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/utils/notification_message.dart';
import 'package:bounce_patient_app/src/shared/widgets/input/custom_textfield.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _userNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool hasAcceptedTerms = false;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _acceptTerms() {
    setState(() {
      hasAcceptedTerms = !hasAcceptedTerms;
    });
  }

  void _createAccount() async {
    if (_formKey.currentState!.validate()) {
      if (!hasAcceptedTerms) {
        Messenger.showError(context, message: 'Agree to Bounce terms and conditions');
        return;
      }

      final controller = context.read<AuthController>();
      try {
        final userId = await controller.createAccount(
          userName: _userNameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        controller.userId = userId;
        controller.email = _emailController.text.trim();
        Messenger.showSucess(context,
            message: 'A confirmation link has been sent to your email');
        AppNavigator.to(
            context,
            IncomingEmailScreen(
                email: _emailController.text.trim(),
                userName: _userNameController.text.trim()));
      } on Failure catch (e) {
        Messenger.showError(context, message: e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        AppNavigator.removeAllUntil(context, const SignInScreen());
        return Future.value(true);
      },
      child: Form(
        key: _formKey,
        child: AuthBody(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Create Account',
                style: AppText.bold600(context).copyWith(
                  fontSize: 24.sp,
                  color: AppColors.primary,
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
              controller: _userNameController,
              lableText: 'User Name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
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
            PasswordTextField(controller: _passwordController),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCheckBox(
                  value: hasAcceptedTerms,
                  onChanged: (value) => _acceptTerms(),
                ),
                SizedBox(width: 5.w),
                LinkText(
                  text1: 'I agree to the BOUNCE',
                  text2: 'Terms and Conditions',
                  onClick: _acceptTerms,
                ),
              ],
            ),
            SizedBox(height: 28.h),
            Consumer<AuthController>(
              builder: (context, controller, _) {
                return AuthButton(
                  label: 'Sign Up',
                  isLoading: controller.isLoading,
                  onTap: _createAccount,
                );
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
        ),
      ),
    );
  }
}
