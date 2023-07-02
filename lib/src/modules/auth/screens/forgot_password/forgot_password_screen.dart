import 'package:bounce_patient_app/src/modules/auth/screens/forgot_password/forgot_password_controller.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/forgot_password/confirmation/forgot_password_confirmation_screen.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/auth_button.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/utils/validator.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/utils/messenger.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/input/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        await context.read<ForgotPasswordController>().execute(email: _emailController.text.trim());

        if (mounted) {
          Messenger.success(
            message: 'Verification code has been sent to ${_emailController.text}',
          );
          AppNavigator.to(context, ForgotPasswordConfirmationScreen(email: _emailController.text));
        }
      } on Failure catch (e) {
        Messenger.error(message: e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: AppPadding.symetricHorizontalOnly,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Forgot password?',
                      style: AppText.bold800(context).copyWith(
                        fontSize: 24.sp,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'We will send you an email to set or reset your new password',
                      style: AppText.bold300(context).copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        AuthIcons.forgotPassword,
                        width: 190.w,
                        height: 201.h,
                      ),
                    ),
                    SizedBox(height: 28.h),
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'Enter your email address',
                      textInputAction: TextInputAction.done,
                      prefixIcon: const TextFieldSvgIcon(icon: AppIcons.mail),
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
                    SizedBox(height: 30.h),
                    Consumer<ForgotPasswordController>(
                      builder: (context, controller, _) {
                        return AuthButton(
                          label: 'Submit',
                          isLoading: controller.isBusy,
                          onTap: submit,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
