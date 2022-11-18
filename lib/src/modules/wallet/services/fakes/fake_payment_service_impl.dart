import 'package:bounce_patient_app/src/modules/wallet/models/transaction_ref.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/payment.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/interfaces/payment_service.dart';

class FakePaymentServiceImpl implements IPaymentService {
  @override
  Future<void> confirmPayment(TransactionRef transactionRef) async {
    // TODO: implement confirmPayment
    throw UnimplementedError();
  }

  @override
  Future<TransactionRef> initiate({
    required PaymentOption paymentOption,
    required double amount,
  }) async {
    // TODO: implement initiate
    throw UnimplementedError();
  }
}
