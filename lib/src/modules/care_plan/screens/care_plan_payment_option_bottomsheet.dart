import 'dart:developer';

import 'package:bounce_patient_app/src/modules/care_plan/controllers/care_plan_controller.dart';
import 'package:bounce_patient_app/src/modules/care_plan/models/plan.dart';
import 'package:bounce_patient_app/src/modules/dashboard/screens/dashboard_view.dart';
import 'package:bounce_patient_app/src/modules/wallet/controllers/payment_controller.dart';
import 'package:bounce_patient_app/src/modules/wallet/controllers/transaction_list_controller.dart';
import 'package:bounce_patient_app/src/modules/wallet/controllers/wallet_controller.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/payment_dto.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/transaction_ref.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

Future<dynamic> showCarePlanPaymentOptionBottomsheet({
  required BuildContext context,
  required SubPlan subplan,
}) {
  return showCustomBottomSheet(
    context,
    isDismissible: false,
    enableDrag: false,
    body: _SelectPaymentOptionBody(subplan),
  );
}

class _SelectPaymentOptionBody extends StatefulWidget {
  const _SelectPaymentOptionBody(this.plan);

  final SubPlan plan;

  @override
  State<_SelectPaymentOptionBody> createState() => _SelectPaymentOptionBodyState();
}

class _SelectPaymentOptionBodyState extends State<_SelectPaymentOptionBody> {
  bool isLoading = false;

  void submit() async {
    try {
      setState(() => isLoading = true);
      final paymentDto = await subscribeToPlan();

      if (paymentDto != null) {
        await payWithWallet(TransactionRef(value: paymentDto.trxRef));
      }
      setState(() => isLoading = false);
    } on Failure catch (e) {
      setState(() => isLoading = false);
      Messenger.error(message: e.message);
    }
  }

  Future<PaymentDto?> subscribeToPlan() async {
    final user = AppSession.user;

    if (user != null) {
      final controller = context.read<CarePlanController>();

      try {
        final trxRef = await controller.subscribeToPlan(widget.plan);
        return PaymentDto(
          trxRef: trxRef.value,
          customerName: user.fullName,
          email: user.email,
          amount: widget.plan.amount,
          narration: 'Care Plan Subscription',
          message: '${widget.plan.title} subscription',
        );
      } on Failure {
        rethrow;
      }
    }
    return null;
  }

  Future<void> payWithWallet(TransactionRef trxRef) async {
    final controller = context.read<PaymentController>();

    try {
      await controller.payWithWallet(trxRef);
      updateWalletDetails();
      AppNavigator.removeAllUntil(context, const DashboardView());
      Messenger.success(message: 'Subscription Successfull');
    } on Failure {
      rethrow;
    }
  }

  void updateWalletDetails() async {
    final controller = context.read<WalletController>();

    try {
      await Future.wait([
        controller.getBalance(),
        context.read<TransactionListController>().getAllTopUp(),
      ]);
    } on Failure {
      log('ERROR => Failed to update wallet details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetBody(
      height: 320.h,
      padding: EdgeInsets.zero,
      body: [
        isLoading
            ? SizedBox(height: 20.h)
            : const Align(
                alignment: Alignment.centerRight,
                child: CloseButton(),
              ),
        Text(
          'Care Plan Subscription',
          style: AppText.bold700(context).copyWith(
            fontSize: 20.sp,
          ),
        ),
        SizedBox(height: 40.h),
        Padding(
          padding: EdgeInsets.only(left: AppPadding.horizontal),
          child: Column(
            children: [
              Text(
                '${widget.plan.title} - ${widget.plan.parentPlantitle} subscription',
                style: AppText.bold300(context),
              ),
              AmountText(
                amount: widget.plan.amount,
                amountFontSize: 24.sp,
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        const CustomDivider(),
        SizedBox(height: 16.h),
        Text(
          'Payment with ThriveX Wallet',
          style: AppText.bold300(context).copyWith(
            fontSize: 11.sp,
          ),
        ),
        const Spacer(),
        Padding(
          padding: AppPadding.symetricHorizontalOnly,
          child: AppButton(
            label: 'Subscribe',
            isLoading: isLoading,
            onTap: submit,
          ),
        ),
        SizedBox(height: 22.h),
      ],
    );
  }
}