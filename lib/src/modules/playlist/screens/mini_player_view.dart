import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miniplayer/miniplayer.dart';

class MiniPlayerView extends StatelessWidget {
  const MiniPlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Miniplayer(
      minHeight: 70.h,
      maxHeight: 352.h,
      backgroundColor: Colors.transparent,
      builder: (height, percentage) => Container(
        height: height,
        decoration: BoxDecoration(
          color: AppColors.grey6,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
        ),
      ),
      onDismiss: () {
        //Handle onDismissed here
      },
    );
  }
}
