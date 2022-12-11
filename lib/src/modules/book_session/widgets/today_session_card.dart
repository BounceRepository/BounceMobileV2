import 'package:bounce_patient_app/src/modules/book_session/models/session.dart';
import 'package:bounce_patient_app/src/modules/book_session/screens/join_session_screen.dart';
import 'package:bounce_patient_app/src/modules/book_session/widgets/sessions_item_tile.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TodaySessionCard extends StatelessWidget {
  const TodaySessionCard(this.session, {super.key});

  final Session session;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 340.w,
          decoration: BoxDecoration(
            color: AppColors.secondary.withOpacity(.52),
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        Positioned(
          top: 24.h,
          bottom: 10.h,
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
                'Upcoming Session',
                style: AppText.bold700(context).copyWith(
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                '${session.therapistName}, ${session.therapistDiscipline}',
                style: AppText.bold400(context).copyWith(
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 6.h),
              SessionDateTimeView(
                icon: Icons.schedule_outlined,
                dateTime: session.startTime,
              ),
              SizedBox(height: 11.18.h),
              bookNowButton(context, session.therapistId),
            ],
          ),
        ),
      ],
    );
  }

  Widget bookNowButton(BuildContext context, int therapistId) {
    return GestureDetector(
      onTap: () {
        AppNavigator.to(context, JoinSessionScreen(therapistId: therapistId));
      },
      child: Text(
        'Join Now',
        style: AppText.bold700(context).copyWith(
          fontSize: 16.sp,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
