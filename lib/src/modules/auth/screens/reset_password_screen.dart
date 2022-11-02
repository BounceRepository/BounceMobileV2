import 'package:bounce_patient_app/src/modules/auth/controllers/auth_controller.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/sign_in_screen.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/auth_button.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/password_textfield.dart';
import 'package:bounce_patient_app/src/shared/helper_functions/validator.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/utils/messenger.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/response_bottomsheets.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_child_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      final controller = context.read<AuthController>();
      try {
        await controller.changePassword(
          email: widget.email,
          newPassword: _newPasswordController.text,
        );
        showResetSuccessBottomsheet(
          context,
          title: 'Password Recovery Successful.',
          desc: 'Return to the login screen to enter the application',
          onTap: () {
            AppNavigator.removeAllUntil(context, const SignInScreen());
          },
        );
      } on Failure catch (e) {
        Messenger.error( message: e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: CustomChildScrollView(
            padding: AppPadding.symetricHorizontalOnly,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Reset Password',
                    style: AppText.bold600(context).copyWith(
                      fontSize: 32.sp,
                    ),
                  ),
                  SizedBox(height: 21.h),
                  Text(
                    'Enter your new and confirm password to reset your password.',
                    textAlign: TextAlign.center,
                    style: AppText.bold500(context).copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 37.h),
                  PasswordTextField(
                    controller: _newPasswordController,
                    hintText: 'Password',
                  ),
                  SizedBox(height: 37.h),
                  PasswordTextField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (PasswordValidator.isNotTheSame(
                          text1: _newPasswordController.text,
                          text2: _confirmPasswordController.text)) {
                        return 'The passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 41.h),
                  Consumer<AuthController>(
                    builder: (context, controller, _) {
                      return AuthButton(
                        label: 'Reset',
                        isLoading: controller.isLoading,
                        onTap: _resetPassword,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
