import 'package:bounce_patient_app/src/modules/dashboard/screens/dashboard_view.dart';
import 'package:bounce_patient_app/src/modules/wallet/controllers/transaction_list_controller.dart';
import 'package:bounce_patient_app/src/modules/wallet/controllers/wallet_controller.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/payment.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/payment_dto.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/transaction_ref.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/impls/flutterwave_payment_service.dart';
import 'package:bounce_patient_app/src/shared/models/app_session.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/messenger.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/amount_text.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_divider.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/select_payment_type_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

Future<dynamic> showWalletTopUpPaymentOptionBottomsheet({
  required BuildContext context,
  required double amount,
}) {
  return showCustomBottomSheet(
    context,
    body: _SelectPaymentOptionBody(amount),
  );
}

class _SelectPaymentOptionBody extends StatefulWidget {
  const _SelectPaymentOptionBody(this.amount);

  final double amount;

  @override
  State<_SelectPaymentOptionBody> createState() => _SelectPaymentOptionBodyState();
}

class _SelectPaymentOptionBodyState extends State<_SelectPaymentOptionBody> {
  PaymentOption? selectedPaymentOption;
  bool isLoading = false;

  void submit() async {
    if (selectedPaymentOption != null) {
      try {
        setState(() => isLoading = true);
        final paymentDto = await initiateTopUp();

        if (paymentDto != null) {
          final paymentService = FlutterwavePaymentService(
            context: context,
            transactionSuccess: confirmTopUp,
          );
          await paymentService.processTransaction(
            paymentDto: paymentDto,
            paymentOption: selectedPaymentOption!,
          );
        }
        setState(() => isLoading = false);
      } on Failure catch (e) {
        setState(() => isLoading = false);
        Messenger.error(message: e.message);
      }
    }
  }

  Future<PaymentDto?> initiateTopUp() async {
    final user = AppSession.user;

    if (user != null) {
      final controller = context.read<WalletController>();

      try {
        final trxRef = await controller.initiateTopUp(widget.amount);
        return PaymentDto(
          trxRef: trxRef.value,
          customerName: user.fullName,
          email: user.email,
          amount: widget.amount.toInt(),
          narration: 'Wallet Top Up',
          message: 'thrive x wallet balance top up',
        );
      } on Failure {
        rethrow;
      }
    }
    return null;
  }

  void confirmTopUp(String trxRef) async {
    final controller = context.read<WalletController>();

    try {
      setState(() => isLoading = true);
      await controller.confirmTopUp(TransactionRef(value: trxRef));
      Future.wait([
        controller.getBalance(),
        context.read<TransactionListController>().getAllTopUp(),
      ]);
      AppNavigator.removeAllUntil(context, const DashboardView());
      Messenger.success(message: 'Wallet Top Up Successfull');
      setState(() => isLoading = false);
    } on Failure catch (e) {
      setState(() => isLoading = false);
      Messenger.error(message: e.message);
    }
  }

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
              amount: widget.amount,
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
            onSelect: (paymentOption) {
              selectedPaymentOption = paymentOption;
            },
          ),
        ),
        const Spacer(),
        Padding(
          padding: AppPadding.symetricHorizontalOnly,
          child: AppButton(
            label: 'Continue',
            isLoading: isLoading,
            onTap: submit,
          ),
        ),
        SizedBox(height: 22.h),
      ],
    );
  }
}
