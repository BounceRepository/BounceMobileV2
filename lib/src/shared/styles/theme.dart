import 'package:flutter/material.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get theme {
    return ThemeData(
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.light,
        primarySwatch: const MaterialColor(
          0xff573926, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
          <int, Color>{
            50: AppColors.primary, //10%
            100: AppColors.primary, //20%
            200: AppColors.primary, //30%
            300: AppColors.primary, //40%
            400: AppColors.primary, //50%
            500: AppColors.primary, //60%
            600: AppColors.primary, //70%
            700: AppColors.primary, //80%
            800: AppColors.primary, //90%
            900: AppColors.primary, //100%
          },
        ),
      ).copyWith(secondary: AppColors.primary),
      //colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      textTheme: GoogleFonts.poppinsTextTheme().apply(
        displayColor: AppColors.textBrown,
        bodyColor: AppColors.textBrown,
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          size: 20.sp,
        ),
      ),
    );
  }
}
