import 'package:bounce_patient_app/src/modules/wallet/models/transaction_ref.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/payment.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/interfaces/payment_service.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';
import 'package:bounce_patient_app/src/shared/utils/utils.dart';

class FakePaymentService implements IPaymentService {
  @override
  Future<TransactionRef> initiate({
    required PaymentOption paymentOption,
    required double amount,
  }) async {
    await fakeNetworkDelay();
    return TransactionRef(value: Utils.getGuid());
  }

  @override
  Future<void> confirmPayment(TransactionRef transactionRef) async {
    await fakeNetworkDelay();
  }

  @override
  Future<void> payWithWallet(TransactionRef trxRef) async {
    await fakeNetworkDelay();
  }
}
