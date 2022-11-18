import 'package:bounce_patient_app/src/modules/book_session/models/session.dart';
import 'package:bounce_patient_app/src/modules/book_session/screens/join_session_screen.dart';
import 'package:bounce_patient_app/src/modules/book_session/screens/reschedule_session_screen.dart';
import 'package:bounce_patient_app/src/modules/book_session/screens/screens.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/helper_functions/datetime_helper_functions.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SessionItemTile extends StatelessWidget {
  const SessionItemTile(this.session, {Key? key}) : super(key: key);

  final Session session;

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Container(
          width: 344.w,
          height: 164.h,
          margin: EdgeInsets.only(bottom: 28.h),
          decoration: BoxDecoration(
            color: AppColors.secondary.withOpacity(.52),
            border: Border.all(color: const Color(0xffF4F4F4)),
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        Positioned(
          top: 24.h,
          bottom: 36.h,
          right: 4.w,
          child: SvgPicture.asset(
            AppIcons.stetoscope,
            width: 88.w,
            height: 104.h,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 16.h,
          left: 16.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                session.therapistName,
                style: AppText.bold800(context).copyWith(
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                session.therapistDiscipline,
                style: AppText.bold400(context).copyWith(
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  _DateTimeView(
                    icon: Icons.schedule_outlined,
                    dateTime: session.period,
                  ),
                  SizedBox(width: 17.25.w),
                  _DateTimeView(
                    icon: Icons.calendar_month,
                    dateTime: session.date,
                  ),
                ],
              ),
              SizedBox(height: 17.67.h),
              Row(
                children: [
                  SizedBox(
                    width: 117.w,
                    height: 40.h,
                    child: AppButton(
                      label: session.isCompleted ? 'Book again' : 'Reschedule',
                      labelSize: 14.sp,
                      padding: EdgeInsets.zero,
                      onTap: session.isCompleted
                          ? () {
                              // AppNavigator.to(
                              //     context, BookSessionScreen(therapist: therapist));
                            }
                          : () {
                              AppNavigator.to(context, RescheduleSessionScreen(session));
                            },
                    ),
                  ),
                  session.isCompleted
                      ? const SizedBox.shrink()
                      : SizedBox(
                          width: 117.w,
                          height: 40.h,
                          child: AppButton(
                            label: 'Join Now',
                            labelSize: 14.sp,
                            labelColor: AppColors.primary,
                            backgroundColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                            onTap: () {
                              // AppNavigator.to(
                              //     context, JoinSessionScreen(therapist: therapist));
                            },
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ],
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
          color: AppColors.lightText,
          size: 20.sp,
        ),
        SizedBox(width: 8.13.w),
        Text(
          dateTime,
          style: AppText.bold400(context).copyWith(
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
