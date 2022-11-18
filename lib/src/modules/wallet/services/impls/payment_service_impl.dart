import 'package:bounce_patient_app/src/modules/wallet/models/transaction_ref.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/payment.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/impls/api_urls.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/interfaces/payment_service.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';

class PaymentServiceImpl implements IPaymentService {
  final IApi _api;

  PaymentServiceImpl({required IApi api}) : _api = api;

  @override
  Future<void> confirmPayment(TransactionRef transactionRef) async {
    var url = PaymentApiURLS.confirm + '?TxRef=${transactionRef.value}';

    try {
      await _api.post(url, body: {});
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }

  @override
  Future<TransactionRef> initiate({
    required PaymentOption paymentOption,
    required double amount,
  }) async {
    var body = {"paymentType": paymentOption.name, "amount": amount};

    try {
      final response = await _api.post(PaymentApiURLS.initiate, body: body);
      return TransactionRef(value: response['data']['transactionRef']);
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }
}
