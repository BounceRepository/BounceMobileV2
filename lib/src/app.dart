import 'package:bounce_patient_app/src/config/notification_config.dart';
import 'package:bounce_patient_app/src/config/providers_wrapper.dart';
import 'package:bounce_patient_app/src/modules/onboarding/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bounce_patient_app/src/shared/styles/theme.dart';
import 'package:get/get.dart';

class ThriveXApp extends StatelessWidget {
  const ThriveXApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NotificationConfig(
      child: ProvidersWrapper(
        child: ScreenUtilInit(
          designSize: const Size(376, 812),
          minTextAdapt: true,
          builder: (BuildContext context, Widget? child) {
            return GetMaterialApp(
              title: 'ThriveX - Patient',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.theme,
              home: const SplashScreen(),
            );
          },
        ),
      ),
    );
  }
}
