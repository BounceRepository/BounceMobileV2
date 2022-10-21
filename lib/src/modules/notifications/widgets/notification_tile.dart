import 'package:bounce_patient_app/src/modules/notifications/widgets/notification_bell.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 144.h,
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 16.h,
        left: 8.w,
        right: 8.w,
        bottom: 12.h,
      ),
      margin: EdgeInsets.only(bottom: 28.h),
      decoration: BoxDecoration(
        color: const Color(0xffFCE7D8),
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: AppColors.boxshadow4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const NotificationBell(),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment successful',
                      style: AppText.bold600(context).copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Your session with Dr Bellamy has been booked for Monday, 5th April 2023.',
                      style: AppText.bold500(context).copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              const _Indicator(),
            ],
          ),
          const Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '12h ago',
              style: AppText.bold500(context).copyWith(
                fontSize: 10.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
      width: 8.h,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
    );
  }
}
