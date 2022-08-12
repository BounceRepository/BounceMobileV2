import 'package:bounce_patient_app/src/modules/auth/screens/sign_in_screen.dart';
import 'package:bounce_patient_app/src/shared/assets/images.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GettingStartedScreen extends StatelessWidget {
  const GettingStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppPadding.symetricHorizontalOnly,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.logo,
                width: 183.w,
                height: 178.h,
              ),
              columnText(
                context,
                title: 'Disclaimer:',
                description:
                    'This is an early demo to only show how the app would look like while showing the basic functions. This prototype is NOT demonstrating the final version.',
              ),
              SizedBox(height: 20.h),
              columnText(
                context,
                title: 'Instructions:',
                description:
                    'Click on the buttons and actions as you would on a regular app. Clicking anywhere on the phone will highlight the possible actions in a blue box. For the purpose of this demonstration, you will be using the application as “Bounce”',
              ),
              SizedBox(height: 40.h),
              AppButton(
                label: 'Get Started',
                onTap: () {
                  AppNavigator.to(context, const SignInScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget columnText(
    BuildContext context, {
    required String title,
    required String description,
  }) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppText.bold700(context).copyWith(
            fontSize: 18.sp,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          description,
          textAlign: TextAlign.center,
          style: AppText.bold500(context).copyWith(
            fontSize: 18.sp,
          ),
        ),
      ],
    );
  }
}
