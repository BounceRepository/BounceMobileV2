import 'package:bounce_patient_app/src/modules/auth/controllers/auth_controller.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/reset_password_screen.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/auth_button.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/link_text.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/utils/messenger.dart';
import 'package:bounce_patient_app/src/shared/widgets/input/custom_pin_code_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late String token;

  void _validateOTP() async {
    if (token.length == 4) {
      final controller = context.read<AuthController>();
      try {
        await controller.validateOTP(token: token);
        Messenger.success( message: '${widget.email} verification successful');
        AppNavigator.to(context, ResetPasswordScreen(email: widget.email));
      } on Failure catch (e) {
        Messenger.error( message: e.message);
      }
    }
  }

  void _sendOTP() async {
    final controller = context.read<AuthController>();
    try {
      await controller.forgotPassword(email: widget.email);
      Messenger.success(
        
        message: 'Verification code has been sent to ${widget.email}',
      );
    } on Failure catch (e) {
      Messenger.error( message: e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //SizedBox(height: 83.79.h),
                SvgPicture.asset(
                  AuthIcons.otp,
                  width: 236.02.w,
                  height: 283.01.h,
                ),
                SizedBox(height: 22.99.h),
                Text(
                  'OTP VERIFICATION',
                  style: AppText.bold500(context).copyWith(
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(height: 17.h),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Enter the OTP sent to ',
                    style: AppText.bold400(context).copyWith(
                      fontSize: 14.sp,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.email,
                        style: AppText.bold600(context).copyWith(
                          fontSize: 14.sp,
                          color: AppColors.textBrown,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 21.h),
                CustomPinCodeTextField(
                  onChanged: (value) {
                    token = value;
                  },
                ),
                SizedBox(height: 26.h),
                Consumer<AuthController>(
                  builder: (context, controller, _) {
                    if (controller.isSendingOTP) {
                      return const CircularProgressIndicator();
                    }

                    return LinkText(
                      text1: 'Didn’t receive code?',
                      text2: 'Re-send',
                      fontSize: 14.sp,
                      onClick: _sendOTP,
                    );
                  },
                ),
                SizedBox(height: 38.h),
                Consumer<AuthController>(
                  builder: (context, controller, _) {
                    return AuthButton(
                      label: 'Submit',
                      isLoading: controller.isLoading,
                      onTap: _validateOTP,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
