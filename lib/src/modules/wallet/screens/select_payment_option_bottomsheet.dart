import 'package:bounce_patient_app/src/modules/wallet/models/payment.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/amount_text.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_divider.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/select_payment_type_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> showSelectPaymentOptionBottomsheet({
  required BuildContext context,
  required double amount,
}) {
  return showCustomBottomSheet(
    context,
    body: _SelectPaymentOptionBody(amount),
  );
}

class _SelectPaymentOptionBody extends StatelessWidget {
  const _SelectPaymentOptionBody(this.amount);

  final double amount;

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetBody(
      height: 488.h,
      padding: EdgeInsets.zero,
      body: [
        SizedBox(height: 20.h),
        Text(
          'My Wallet Top Up',
          style: AppText.bold700(context).copyWith(
            fontSize: 20.sp,
          ),
        ),
        SizedBox(height: 40.h),
        Padding(
          padding: EdgeInsets.only(left: AppPadding.horizontal),
          child: Align(
            alignment: Alignment.centerLeft,
            child: AmountText(
              amount: amount,
              amountFontSize: 24.sp,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        const CustomDivider(),
        SizedBox(height: 41.h),
        Padding(
          padding: AppPadding.symetricHorizontalOnly,
          child: SelectPaymentTypeView(
            options: const [PaymentOption.card, PaymentOption.ussd],
            onSelect: (type) {},
          ),
        ),
        const Spacer(),
        Padding(
          padding: AppPadding.symetricHorizontalOnly,
          child: AppButton(
            label: 'Continue',
            onTap: () {},
          ),
        ),
        SizedBox(height: 22.h),
      ],
    );
  }
}
