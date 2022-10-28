import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AmountText extends StatelessWidget {
  const AmountText({
    Key? key,
    required this.amount,
    this.color,
    this.amountFontSize,
    this.fontWeight,
    this.symbolFontSize,
    this.decoration,
  }) : super(key: key);

  final num amount;
  final Color? color;
  final double? amountFontSize;
  final double? symbolFontSize;
  final TextDecoration? decoration;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###,##0.00');

    return RichText(
      text: TextSpan(
        text: AppConstants.nairaSymbol,
        style: TextStyle(
          color: color ?? AppColors.lightText,
          fontSize: symbolFontSize ?? amountFontSize ?? 16.sp,
          fontWeight: fontWeight ?? FontWeight.w900,
          decoration: decoration,
        ),
        children: <TextSpan>[
          TextSpan(
            text: formatter.format(amount).toString(),
            style: AppText.bold900(context).copyWith(
              color: color,
              fontSize: amountFontSize ?? 16.sp,
              fontWeight: fontWeight,
              decoration: decoration,
            ),
          ),
        ],
      ),
    );
  }
}
