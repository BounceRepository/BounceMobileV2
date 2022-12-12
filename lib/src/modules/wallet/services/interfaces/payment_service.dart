import 'package:bounce_patient_app/src/modules/wallet/models/payment.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/transaction_ref.dart';

abstract class IPaymentService {
  Future<TransactionRef> initiate({
    required PaymentOption paymentOption,
    required double amount,
  });
  Future<void> confirmPayment(TransactionRef trxRef);
  Future<void> payWithWallet(TransactionRef trxRef);
}
