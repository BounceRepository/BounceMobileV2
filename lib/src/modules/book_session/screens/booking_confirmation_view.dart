import 'package:bounce_patient_app/src/modules/book_session/controllers/book_session_controller.dart';
import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/book_session/widgets/amount_per_hour_view.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/assets/images.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/utils/datetime_utils.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BookingConfirmationView extends StatelessWidget {
  const BookingConfirmationView({Key? key, required this.therapist}) : super(key: key);

  final Therapist therapist;

  String getTimeRange(String startTime) {
    final startTimeOfDay = DateTimeUtils.convertAMPMToTimeOfDay(startTime);
    final endTimeOfDay = TimeOfDay(
      hour: startTimeOfDay.hour + 1,
      minute: startTimeOfDay.minute,
    );
    final endTime = DateTimeUtils.convertTimeOfDayToAMPM(endTimeOfDay);
    return '$startTime - $endTime';
  }

  @override
  Widget build(BuildContext context) {
    final doctorName = '${therapist.title} ${therapist.firstName}';
    final controller = context.read<BookSessionController>();
    final selectedDate = controller.selectedDate;
    final selectedTime = controller.selectedTime;

    if (selectedTime == null) {
      return const SizedBox.shrink();
    }

    final date = DateTimeUtils.getDateFullStr(selectedDate);
    final time = getTimeRange(selectedTime);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          AppImages.bookingConfirmation,
          height: 234.h,
          width: 376.w,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 20.h),
        Padding(
          padding: AppPadding.symetricHorizontalOnly,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctorName,
                style: AppText.bold500(context).copyWith(
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                therapist.specializationList,
                style: AppText.bold400(context).copyWith(
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 20.h),
              tile(
                context,
                icon: AppIcons.calendar,
                label: date,
              ),
              SizedBox(height: 8.h),
              tile(
                context,
                icon: AppIcons.clock,
                label: time,
              ),
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: AppPadding.symetricHorizontalOnly,
          child: Column(
            children: [
              AmountChargedTile(
                  title: 'Service charge', amount: therapist.serviceChargePerHour),
              SizedBox(height: 54.h),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: 'Back',
                      labelColor: AppColors.lightText,
                      backgroundColor: Colors.grey.withOpacity(.5),
                      onTap: () {
                        DefaultTabController.of(context)!.animateTo(0);
                      },
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: AppButton(
                      label: 'Payment',
                      onTap: () {
                        DefaultTabController.of(context)!.animateTo(2);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 40.h),
      ],
    );
  }

  Widget tile(
    BuildContext context, {
    required String icon,
    required String label,
  }) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          height: 20.h,
          width: 20.h,
          fit: BoxFit.fill,
        ),
        SizedBox(width: 8.w),
        Text(
          label,
          style: AppText.bold400(context).copyWith(
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}

class AmountChargedTile extends StatelessWidget {
  const AmountChargedTile({
    Key? key,
    required this.title,
    required this.amount,
  }) : super(key: key);

  final String title;
  final int amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppText.bold400(context).copyWith(
            fontSize: 16.sp,
          ),
        ),
        SizedBox(width: 12.w),
        AmountPerHourView(amount: amount),
      ],
    );
  }
}
