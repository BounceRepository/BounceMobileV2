import 'dart:async';
import 'dart:developer';

import 'package:bounce_patient_app/src/local_storage/local_storage_service.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/welcome_back_screen.dart';
import 'package:bounce_patient_app/src/modules/onboarding/controllers/onboarding_controller.dart';
import 'package:bounce_patient_app/src/modules/onboarding/screens/onboarding_screen.dart';
import 'package:bounce_patient_app/src/shared/assets/images.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () async {
      String? userName;
      String? email;

      try {
        userName = await getUserName();
        email = await getEmail();

        if (email != null && userName != null) {
          AppNavigator.removeAllUntil(
              context, WelcomeBackScreen(email: email, userName: userName));
        } else {
          AppNavigator.removeAllUntil(context, const OnboardingScreen());
        }
      } on Failure catch (e) {
        log(e.message);
      }
    });
  }

  Future<String?> getUserName() async {
    try {
      final name = await LocalStorageService.getUserName();
      return name;
    } on Failure {
      LocalStorageService.clear();
    }
    return null;
  }

  Future<String?> getEmail() async {
    try {
      final email = await LocalStorageService.getEmail();
      return email;
    } on Failure {
      LocalStorageService.clear();
    }
    return null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImages();
  }

  void precacheImages() async {
    final controller = context.read<OnboardingController>();
    controller.precacheImages(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              AppImages.logo,
              width: 100.h,
              height: 100.h,
              fit: BoxFit.fill,
            ),
          ),
          Text(
            'ThriveX',
            textAlign: TextAlign.center,
            style: GoogleFonts.oldenburg(
              fontWeight: FontWeight.w400,
              fontSize: 20.sp,
              color: const Color(0xff89B031),
            ),
          ),
        ],
      ),
    );
  }
}
