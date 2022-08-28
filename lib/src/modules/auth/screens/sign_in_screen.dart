import 'package:bounce_patient_app/src/modules/auth/controllers/auth_controller.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/forgot_password_screen.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/sign_up_screen.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/social_auth_view.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/auth_body.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/auth_button.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/link_text.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/password_textfield.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/helper_functions/validator.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/utils/notification_message.dart';
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

  void _signIn() async {
    if (_formKey.currentState!.validate()) {
      final controller = context.read<AuthController>();
      try {
        await controller.signIn(
          userName: _emailController.text,
          password: _passwordController.text,
        );
        NotificationMessage.showSucess(context, message: 'Login successful');
        //TODO: Navigate to dashboard
      } on Failure catch (e) {
        NotificationMessage.showError(context, message: e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: AuthBody(
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
          Consumer<AuthController>(
            builder: (context, controller, _) {
              return AuthButton(
                label: 'Sign In',
                isLoading: controller.isLoading,
                onTap: _signIn,
              );
            },
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
          SizedBox(height: 39.h),
        ],
      ),
    );
  }
}
