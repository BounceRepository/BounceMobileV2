import 'package:bounce_patient_app/src/modules/auth/screens/sign_in_screen.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/auth_button.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/success_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/widgets/input/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppPadding.symetricHorizontalOnly,
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
            CustomTextField(
              controller: TextEditingController(),
              hintText: 'Password',
              suffixIcon: PasswordIcon(
                true,
                onTap: () {},
              ),
            ),
            SizedBox(height: 37.h),
            CustomTextField(
              controller: TextEditingController(),
              hintText: 'Confirm password',
              suffixIcon: PasswordIcon(
                true,
                onTap: () {},
              ),
            ),
            SizedBox(height: 41.h),
            AuthButton(
              label: 'Reset',
              onTap: () {
                showSuccessBottomsheet(
                  context,
                  title: 'Password Recovery Successful.',
                  desc: 'Return to the login screen to enter the application',
                  onTap: () {
                    AppNavigator.pushAndRemoveUntil(context, const SignInScreen());
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
