import 'package:bounce_patient_app/src/modules/notifications/models/notification.dart';
import 'package:bounce_patient_app/src/modules/notifications/widgets/notification_bell.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationTile extends StatelessWidget {
  const NotificationTile(this.notification, {super.key});

  final NotificationMessage notification;

  @override
  Widget build(BuildContext context) {
    final loadedTime = notification.createdAt.toLocal();
    final date = timeago.format(loadedTime);

    return Container(
      height: 154.h,
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 16.h,
        left: 8.w,
        right: 8.w,
        bottom: 12.h,
      ),
      margin: EdgeInsets.only(bottom: 28.h),
      decoration: BoxDecoration(
        color: notification.isRead ? AppColors.lightVersion : const Color(0xffFCE7D8),
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
                      notification.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.bold600(context).copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      notification.body,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.bold500(context).copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              notification.isRead ? const SizedBox.shrink() : const _Indicator(),
            ],
          ),
          const Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              date,
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
