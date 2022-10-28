import 'dart:ui';

import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
        child: Container(
          height: 48.h,
          width: 48.h,
          padding: EdgeInsets.all(10.sp),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.2),
          ),
          child: SvgPicture.asset(
            MusicIcons.play,
            color: Colors.white,
            height: 24.h,
            width: 24.h,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
