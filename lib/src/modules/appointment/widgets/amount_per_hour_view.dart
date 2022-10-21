import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AmountPerHourView extends StatelessWidget {
  const AmountPerHourView({
    Key? key,
    required this.amount,
  }) : super(key: key);

  final int amount;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '${AppConstants.nairaSymbol}$amount',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18.sp,
          color: AppColors.lightText,
        ),
        children: <TextSpan>[
          TextSpan(
            text: '/hour',
            style: AppText.bold400(context).copyWith(
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}