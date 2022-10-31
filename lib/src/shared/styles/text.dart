import 'package:flutter/material.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText {
  AppText._();

  static TextStyle titleStyle(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
      color: AppColors.lightText,
      fontWeight: FontWeight.w400,
      fontSize: 16.sp,
    );
  }

  static TextStyle bold300(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
      color: AppColors.lightText,
      fontWeight: FontWeight.w300,
    );
  }

  static TextStyle bold400(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
      color: AppColors.lightText,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle bold500(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
      color: AppColors.lightText,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle bold600(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
      color: AppColors.lightText,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle bold700(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
      color: AppColors.lightText,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle bold800(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
      color: AppColors.lightText,
      fontWeight: FontWeight.w800,
    );
  }

  static TextStyle bold900(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
      color: AppColors.lightText,
      fontWeight: FontWeight.w900,
    );
  }
}
