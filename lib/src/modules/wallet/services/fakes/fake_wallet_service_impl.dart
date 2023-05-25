import 'package:bounce_patient_app/src/modules/wallet/models/transaction_ref.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/interfaces/wallet_service.dart';
import 'package:bounce_patient_app/src/shared/utils/utils.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';

class FakeWalletService implements IWalletService {
  @override
  Future<void> confirmTopUp(TransactionRef ref) async {
    await fakeNetworkDelay();
  }

  @override
  Future<double> getBalance() async {
    await fakeNetworkDelay();
    return 2000;
  }

  @override
  Future<TransactionRef> initiateTopUp(double amount) async {
    await fakeNetworkDelay();
    return TransactionRef(value: Utils.getGuid());
  }
}
