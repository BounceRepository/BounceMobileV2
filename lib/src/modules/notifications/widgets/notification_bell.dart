import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationBell extends StatelessWidget {
  const NotificationBell({
    Key? key,
    this.count = 0,
  }) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SvgPicture.asset(
          AppIcons.notification,
          height: 24.h,
          width: 24.h,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: -4.h,
          right: -5.w,
          bottom: 12.h,
          child: _Badge(count: count),
        ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    if (count == 0) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 16.h,
      width: 16.h,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        count.toString(),
        textAlign: TextAlign.center,
        style: AppText.bold700(context).copyWith(
          fontSize: 9.sp,
          color: AppColors.lightVersion,
        ),
      ),
    );
  }
}
