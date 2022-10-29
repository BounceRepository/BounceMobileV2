import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/amount_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Wallet Top Up',
            style: AppText.bold600(context).copyWith(
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Your wallet top up was successful.',
            style: AppText.bold300(context).copyWith(
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 8.h),
          AmountText(
            amount: 5000.00,
            color: AppColors.success,
            amountFontSize: 20.sp,
          ),
          AmountText(
            amount: 8000.00,
            amountFontSize: 12.sp,
          ),
          SizedBox(height: 2.h),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Mon, 26 Apr 2022 09:43 PM',
              style: AppText.bold400(context).copyWith(
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
