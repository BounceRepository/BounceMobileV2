import 'package:bounce_patient_app/src/modules/wallet/models/transaction_ref.dart';

abstract class IWalletService {
  Future<double> getBalance();
  Future<TransactionRef> initiateTopUp(double amount);
  Future<void> confirmTopUp(TransactionRef txRef);
}
