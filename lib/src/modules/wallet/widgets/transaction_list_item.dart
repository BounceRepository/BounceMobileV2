import 'package:bounce_patient_app/src/modules/wallet/models/transaction.dart';
import 'package:bounce_patient_app/src/shared/extensions/string.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/amount_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem(this.transaction, {super.key});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            transaction.title.toTitleCase,
            style: AppText.bold600(context).copyWith(
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            transaction.desc,
            style: AppText.bold300(context).copyWith(
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 8.h),
          AmountText(
            amount: 5000.00,
            color: transaction.type == TransactionType.credit
                ? AppColors.success
                : AppColors.error,
            amountFontSize: 20.sp,
          ),
          // AmountText(
          //   amount: 8000.00,
          //   amountFontSize: 12.sp,
          // ),
          SizedBox(height: 2.h),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              transaction.createdAt,
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
