import 'package:bounce_patient_app/src/modules/appointment/screens/screens.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookingConfirmationView extends StatelessWidget {
  const BookingConfirmationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 234.h,
          color: Colors.black,
        ),
        Expanded(
          child: Padding(
            padding: AppPadding.defaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dr Bellamy',
                  style: AppText.bold500(context).copyWith(
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Psychiatry • Psychiatry',
                  style: AppText.bold400(context).copyWith(
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 20.h),
                tile(
                  context,
                  icon: AppIcons.calendar,
                  label: '26th April 2023',
                ),
                SizedBox(height: 8.h),
                tile(
                  context,
                  icon: AppIcons.clock,
                  label: '7:30 PM - 8:30 PM',
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
                    const AmountPerHourView(),
                  ],
                ),
                SizedBox(height: 54.h),
                AppButton(
                  label: 'Payment',
                  onTap: () {},
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
