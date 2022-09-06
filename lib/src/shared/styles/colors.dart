import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const primary = Color(0xffEF873D);
  static const textBrown = Color(0xff573926);
  static const textGrey = Color(0xff707070);
  static const background = Color(0xffFBFBFB);
  static const error = Color(0xffEF1313);
  static const border = Color(0xffD9D8D8);
  static const grey = Color(0xffF9F6F4);
  static const chatRoom = Color(0xff89B031);

  static final boxshadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.15),
      spreadRadius: 2,
      blurRadius: 6,
      offset: const Offset(0, 2),
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.3),
      spreadRadius: 0,
      blurRadius: 2,
      offset: const Offset(0, 1),
    ),
  ];
  static const gradient = LinearGradient(
    colors: [
      Color(0xff1C71B7),
      Color(0xff09263D),
    ],
  );
}
