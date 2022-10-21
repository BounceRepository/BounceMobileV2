import 'package:bounce_patient_app/src/modules/appointment/controllers/session_booking_controller.dart';
import 'package:bounce_patient_app/src/modules/appointment/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/appointment/widgets/amount_per_hour_view.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/assets/images.dart';
import 'package:bounce_patient_app/src/shared/helper_functions/datetime_helper_functions.dart';
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
    final startTimeOfDay = DateTimeHelperFunctions.parseTimeOfDay(startTime);
    final endTimeOfDay = TimeOfDay(
      hour: startTimeOfDay.hour + 1,
      minute: startTimeOfDay.minute,
    );
    final endTime = DateTimeHelperFunctions.convertTimeOfDayToAMPM(endTimeOfDay);
    return '$startTime - $endTime';
  }

  @override
  Widget build(BuildContext context) {
    final doctorName = '${therapist.title} ${therapist.firstName}';
    final controller = context.read<SessionBookingController>();
    final selectedDate = controller.selectedDate;
    final selectedTime = controller.selectedTime;

    if (selectedDate == null) {
      return const SizedBox.shrink();
    }

    if (selectedTime == null) {
      return const SizedBox.shrink();
    }

    final date = DateTimeHelperFunctions.getDateFullStr(selectedDate);
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
        Expanded(
          child: Padding(
            padding: AppPadding.defaultPadding,
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
                SizedBox(height: 118.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Service charge:',
                      style: AppText.bold400(context).copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    AmountPerHourView(amount: therapist.serviceChargePerHour),
                  ],
                ),
                SizedBox(height: 54.h),
                AppButton(
                  label: 'Payment',
                  onTap: () {
                    DefaultTabController.of(context)!.animateTo(2);
                  },
                ),
              ],
            ),
          ),
        ),
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
