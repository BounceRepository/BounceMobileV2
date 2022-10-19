import 'package:bounce_patient_app/src/modules/auth/constants/constants.dart';
import 'package:bounce_patient_app/src/modules/auth/controllers/auth_controller.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/create_profile_screen.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/auth_button.dart';
import 'package:bounce_patient_app/src/shared/assets/images.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/utils/notification_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class IncomingEmailScreen extends StatelessWidget {
  const IncomingEmailScreen({
    Key? key,
    required this.email,
    required this.userName,
  }) : super(key: key);

  final String email;
  final String userName;

  void _checkEmailStatus(BuildContext context) async {
    final controller = context.read<AuthController>();
    try {
      final status = await controller.getVerificationStatus(email: email);
      if (status) {
        AppNavigator.removeAllUntil(
            context,
            _VerifiedSuccessScreen(
              email: email,
              userName: userName,
            ));
      } else {
        AppNavigator.to(context, const _VerificationErrorScreen());
      }
    } on Failure catch (e) {
      Messenger.showError(context, message: e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = AppText.bold700(context).copyWith(
      fontSize: 12.sp,
    );
    final controller = context.watch<AuthController>();

    return _RegistrationStatusScreen(
      icon: AuthImages.verified,
      text: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Welcome ',
          style: textStyle,
          children: <TextSpan>[
            TextSpan(
              text: '$userName, ',
              style: textStyle.copyWith(
                color: AppColors.primary,
              ),
            ),
            TextSpan(
              text:
                  'Please verify your email address by clicking on the link sent to your email, then click the button below to check status.',
              style: textStyle,
            ),
          ],
        ),
      ),
      buttonLabel: 'Check email verification status',
      isLoading: controller.isLoading,
      onTap: () => _checkEmailStatus(context),
    );
  }
}

class _VerifiedSuccessScreen extends StatelessWidget {
  const _VerifiedSuccessScreen({Key? key, required this.email, required this.userName})
      : super(key: key);

  final String email;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return VerificationStatusScreen(
      icon: AuthImages.verified,
      description: 'Your email is successfully verified.',
      buttonLabel: 'Continue',
      onTap: () {
        AppNavigator.removeAllUntil(
            context,
            CreateProfileScreen(
              email: email,
              userName: userName,
            ));
      },
    );
  }
}

class _VerificationErrorScreen extends StatelessWidget {
  const _VerificationErrorScreen({Key? key}) : super(key: key);

  void _sendLink(BuildContext context) async {
    final controller = context.read<AuthController>();
    final email = controller.email;
    if (email != null) {
      try {
        await controller.verifyEmail(email: email);
        Messenger.showSucess(context,
            message: 'A confirmation link has been sent to your email');
        Navigator.pop(context);
      } on Failure catch (e) {
        Messenger.showError(context, message: e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, controller, _) {
        return VerificationStatusScreen(
          icon: AuthImages.expired,
          description: AuthConstants.verificationLinkExpired,
          buttonLabel: 'Resend Link',
          isLoading: controller.isLoading,
          onTap: () => _sendLink(context),
        );
      },
    );
  }
}

class VerificationStatusScreen extends StatelessWidget {
  const VerificationStatusScreen({
    Key? key,
    required this.icon,
    required this.description,
    required this.buttonLabel,
    required this.onTap,
    this.isLoading = false,
  }) : super(key: key);
  final String icon;

  final String description;
  final String buttonLabel;
  final Function() onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return _RegistrationStatusScreen(
      icon: icon,
      text: Text(
        description,
        textAlign: TextAlign.center,
        style: AppText.bold700(context).copyWith(
          fontSize: 12.sp,
        ),
      ),
      buttonLabel: buttonLabel,
      isLoading: isLoading,
      onTap: onTap,
    );
  }
}

class _RegistrationStatusScreen extends StatelessWidget {
  const _RegistrationStatusScreen({
    Key? key,
    required this.icon,
    required this.text,
    required this.buttonLabel,
    required this.onTap,
    this.isLoading = false,
  }) : super(key: key);

  final String icon;
  final Widget text;
  final String buttonLabel;
  final Function() onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppPadding.symetricHorizontalOnly,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 187.w,
              height: 180.h,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Image.asset(
                icon,
                width: 143.w,
                height: 113.h,
              ),
            ),
            SizedBox(height: 48.h),
            text,
            SizedBox(height: 48.h),
            AuthButton(
              label: buttonLabel,
              isLoading: isLoading,
              onTap: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
