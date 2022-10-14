import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingPaymentView extends StatelessWidget {
  const BookingPaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.symetricHorizontalOnly,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40.h),
          Text(
            'Choose Payment',
            style: AppText.titleStyle(context),
          ),
          SizedBox(height: 20.h),
          _Tile(
            title: 'Pay with Wallet',
            onTap: () {},
          ),
          SizedBox(height: 12.h),
          _Tile(
            title: 'Pay with Card',
            onTap: () {},
          ),
          SizedBox(height: 360.h),
          AppButton(
            label: 'Book Session',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 18.4.w),
      decoration: BoxDecoration(
        color: const Color(0xffFEFEFE),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: AppColors.boxshadow4,
      ),
      child: Row(
        children: [
          Container(
            height: 19.2.h,
            width: 19.2.h,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 58.4.w),
          Text(
            title,
            style: AppText.bold400(context).copyWith(
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
