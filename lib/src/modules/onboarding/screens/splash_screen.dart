import 'dart:async';

import 'package:bounce_patient_app/src/modules/onboarding/controllers/onboarding_controller.dart';
import 'package:bounce_patient_app/src/modules/onboarding/screens/onboarding_screen.dart';
import 'package:bounce_patient_app/src/shared/assets/images.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      // Navigate to next screen
      AppNavigator.to(context, const OnboardingScreen());
    });
  }

  void precacheImages() async {
    final controller = context.read<OnboardingController>();
    controller.precacheImages(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: Image.asset(
          AppImages.logo,
          width: 183.w,
          height: 178.h,
        ),
      ),
    );
  }
}
