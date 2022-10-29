import 'package:bounce_patient_app/src/modules/wallet/screens/select_payment_option_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/input/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> showTopUpBottomsheet({
  required BuildContext context,
}) {
  return showCustomBottomSheet(
    context,
    body: const _AmountInputBody(),
  );
}

class _AmountInputBody extends StatefulWidget {
  const _AmountInputBody();

  @override
  State<_AmountInputBody> createState() => _AmountInputBodyState();
}

class _AmountInputBodyState extends State<_AmountInputBody> {
  late final TextEditingController amountController;

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetBody(
      height: 488.h,
      body: [
        BottomSheetTitle('My Wallet Top Up'),
        SizedBox(height: 64.h),
        CustomTextField(
          controller: amountController,
          hintText: 'Amount',
        ),
        SizedBox(height: 20.h),
        Text(
          'Money credited into your wallet can only be used on this app and cannot be withdrawn.',
          style: AppText.bold400(context).copyWith(
            fontSize: 14.sp,
          ),
        ),
        const Spacer(),
        AppButton(
          label: 'Continue',
          onTap: () {
            showSelectPaymentOptionBottomsheet(context: context);
          },
        ),
        SizedBox(height: 22.h),
      ],
    );
  }
}


