import 'package:bounce_patient_app/src/config/providers_wrapper.dart';
import 'package:bounce_patient_app/src/modules/onboarding/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bounce_patient_app/src/shared/styles/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProvidersWrapper(
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            title: 'Bounce - Patient',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.theme,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
