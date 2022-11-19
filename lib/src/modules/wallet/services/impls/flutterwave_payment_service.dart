import 'package:bounce_patient_app/src/modules/wallet/models/payment.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/payment_dto.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/transaction_ref.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterwave_standard/core/TransactionCallBack.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:flutterwave_standard/models/TransactionError.dart';
import 'package:flutterwave_standard/models/requests/standard_request.dart';
import 'package:flutterwave_standard/view/standard_webview.dart';
import 'package:flutterwave_standard/view/view_utils.dart';
import 'package:http/http.dart';

class FlutterwavePaymentService implements TransactionCallBack {
  final BuildContext context;

  FlutterwavePaymentService({required this.context});

  Future<TransactionRef?> processTransaction({
    required PaymentDto paymentDto,
    required PaymentOption paymentOption,
  }) async {
    final request = _initializeFlutterwaveDependencies(
      paymentDto: paymentDto,
      paymentOption: paymentOption,
    );

    try {
      return await _executeTransaction(request);
    } on Failure catch (e) {
      FlutterwaveViewUtils.showToast(context, e.message);
      Navigator.pop(context);
    }
    return null;
  }

  StandardRequest _initializeFlutterwaveDependencies({
    required PaymentDto paymentDto,
    required PaymentOption paymentOption,
  }) {
    final customer = Customer(
      name: paymentDto.customerName,
      phoneNumber: "+2347017247035",
      email: paymentDto.email,
    );
    const paymentOptions = 'ussd, card';
    final customization = Customization(
      title: paymentDto.narration,
      description: paymentDto.message,
    );

    return StandardRequest(
      txRef: paymentDto.trxRef,
      amount: paymentDto.amount.toString(),
      customer: customer,
      paymentOptions: paymentOptions,
      customization: customization,
      isTestMode: true,
      publicKey: AppConstants.flutterwavePublicKey,
      redirectUrl: 'https://www.google.com/',
      currency: 'NGN',
    );
  }

  Future<TransactionRef?> _executeTransaction(StandardRequest request) async {
    try {
      final response = await request.execute(Client());

      if (response.status == 'error') {
        throw TransactionError(response.message!);
      }

      final transactionResult =
          await AppNavigator.to(context, StandardWebView(url: response.data!.link!));

      if (transactionResult == null) {
        FlutterwaveViewUtils.showToast(context, "Transaction Cancelled");
        Navigator.pop(context);
      }

      if (transactionResult.runtimeType == ChargeResponse().runtimeType) {
        return TransactionRef(value: request.txRef);
      }
    } catch (e) {
      throw Failure("Transaction Error");
    }
    return null;
  }

  @override
  onCancelled() {
    FlutterwaveViewUtils.showToast(context, "Transaction Cancelled");
    Navigator.pop(context);
  }

  @override
  onTransactionError() {
    FlutterwaveViewUtils.showToast(context, "Transaction Error");
    Navigator.pop(context);
  }

  @override
  onTransactionSuccess(String id, String txRef) async {
    // try {
    //   await confirmPayment(txRef);
    //   showSuccessBottomsheet(
    //     context,
    //     desc: 'Your prefered doctor would be available please proceed.',
    //     onTap: () {
    //       AppNavigator.removeAllUntil(context, nextScreen);
    //     },
    //   );
    // } on Failure {
    //   showErrorBottomsheet(
    //     context,
    //     desc: 'Error occuried',
    //     onTap: () {
    //       AppNavigator.removeAllUntil(context, nextScreen);
    //     },
    //   );
    // }
  }
}
