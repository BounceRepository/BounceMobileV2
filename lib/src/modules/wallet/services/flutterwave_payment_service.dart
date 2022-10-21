import 'package:bounce_patient_app/src/modules/appointment/controllers/book_appointment_controller.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/payment_dto.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/response_bottomsheets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterwave_standard/core/TransactionCallBack.dart';
import 'package:flutterwave_standard/core/navigation_controller.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:flutterwave_standard/models/TransactionError.dart';
import 'package:flutterwave_standard/models/requests/standard_request.dart';
import 'package:flutterwave_standard/view/view_utils.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class FlutterwavePaymentService implements TransactionCallBack {
  /// After successfull transaction, flutterwave webview navigates to
  ///  [nextScreen]
  final BuildContext context;
  final Widget nextScreen;

  FlutterwavePaymentService({
    required this.context,
    required this.nextScreen,
  });

  Future<void> processTransaction(PaymentDto paymentDto) async {
    final request = _initializeFlutterwaveDependencies(paymentDto);

    try {
      await _executeTransaction(request);
    } on Failure {
      rethrow;
    }
  }

  StandardRequest _initializeFlutterwaveDependencies(PaymentDto paymentDto) {
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

  Future<void> _executeTransaction(StandardRequest request) async {
    final navigationController = NavigationController(Client(), FlutterwaveStyle(), this);

    try {
      final response = await request.execute(navigationController.client);

      if (response.status == 'error') {
        throw TransactionError(response.message!);
      }

      navigationController.openBrowser(response.data?.link ?? '', request.redirectUrl);
    } catch (e) {
      throw Failure('Transaction failed');
    }
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
    try {
      await confirmPayment(txRef);
      showSuccessBottomsheet(
        context,
        desc: 'Your prefered doctor would be available please proceed.',
        onTap: () {
          AppNavigator.removeAllUntil(context, nextScreen);
        },
      );
    } on Failure {
      showErrorBottomsheet(
        context,
        desc: 'Error occuried',
        onTap: () {
          AppNavigator.removeAllUntil(context, nextScreen);
        },
      );
    }
  }

  Future<void> confirmPayment(String trxRef) async {
    final controller = context.read<BookAppointmentController>();
    try {
      await controller.confirmAppointment(trxRef);
    } on Failure {
      rethrow;
    }
  }
}
