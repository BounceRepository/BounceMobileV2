import 'package:bounce_patient_app/src/modules/wallet/screens/select_payment_option_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/input/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _formKey = GlobalKey<FormState>();
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

  void submit() {
    if (_formKey.currentState!.validate()) {
      final amount = double.tryParse(amountController.text);

      if (amount != null) {
        showWalletTopUpPaymentOptionBottomsheet(context: context, amount: amount);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: CustomBottomSheetBody(
          //height: 488.h,
          body: [
            const BottomSheetTitle('My Wallet Top Up'),
            SizedBox(height: 64.h),
            CustomTextField(
              controller: amountController,
              hintText: 'Amount',
              textInputType: TextInputType.number,
              textInputAction: TextInputAction.done,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the amount';
                }
                if (value.startsWith('0')) {
                  return 'Enter a valid amount';
                }
                return null;
              },
            ),
            SizedBox(height: 20.h),
            Text(
              'Money credited into your wallet can only be used on this app and cannot be withdrawn.',
              style: AppText.bold400(context).copyWith(
                fontSize: 14.sp,
              ),
            ),
            //const Spacer(),
            SizedBox(height: 185.h),
            AppButton(
              label: 'Continue',
              onTap: submit,
            ),
            SizedBox(height: 22.h),
          ],
        ),
      ),
    );
  }
}
