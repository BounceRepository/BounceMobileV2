import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SessionItemTile extends StatelessWidget {
  const SessionItemTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.only(top: 21.h, bottom: 16.h, left: 15.w, right: 15.w),
      decoration: BoxDecoration(
        color: const Color(0xffF8F6F5),
        border: Border.all(color: const Color(0xffF4F4F4)),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 35.h,
                width: 35.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                  border: Border.all(color: AppColors.primary),
                ),
              ),
              SizedBox(width: 17.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sahana V',
                    style: AppText.bold600(context).copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 2.27.h),
                  Text(
                    'Msc in Clinical Psychology',
                    style: AppText.bold400(context).copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(height: 1.h, color: const Color(0xffD9D8D8).withOpacity(.3)),
          SizedBox(height: 12.h),
          Row(
            children: [
              const _DateTimeView(
                icon: Icons.calendar_month,
                dateTime: '31st March ‘22',
              ),
              SizedBox(width: 17.25.w),
              const _DateTimeView(
                icon: Icons.schedule_outlined,
                dateTime: '7:30 PM - 8:30 PM',
              ),
            ],
          ),
          SizedBox(height: 14.h),
          const _ActionButtons(),
        ],
      ),
    );
  }
}

class _DateTimeView extends StatelessWidget {
  const _DateTimeView({
    Key? key,
    required this.icon,
    required this.dateTime,
  }) : super(key: key);

  final IconData icon;
  final String dateTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xffD6CCC6),
          size: 20.sp,
        ),
        SizedBox(width: 8.13.w),
        Text(
          dateTime,
          style: AppText.bold400(context).copyWith(
            fontSize: 12.sp,
            color: const Color(0xff707070),
          ),
        ),
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 117.w,
          child: AppButton(
            label: 'Reschedule',
            labelSize: 14.sp,
            onTap: () {},
          ),
        ),
        SizedBox(width: 20.w),
        SizedBox(
          width: 117.w,
          child: AppButton(
            label: 'Join Now',
            labelSize: 14.sp,
            labelColor: AppColors.primary,
            backgroundColor: Colors.transparent,
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
