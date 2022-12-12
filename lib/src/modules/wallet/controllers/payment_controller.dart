import 'package:bounce_patient_app/src/modules/wallet/models/transaction_ref.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/interfaces/payment_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

class PaymentController extends BaseController {
  final IPaymentService _paymentService;

  PaymentController({required IPaymentService paymentService})
      : _paymentService = paymentService;

  Future<void> payWithWallet(TransactionRef trxRef) async {
    try {
      await _paymentService.payWithWallet(trxRef);
    } on Failure {
      rethrow;
    }
  }
}
