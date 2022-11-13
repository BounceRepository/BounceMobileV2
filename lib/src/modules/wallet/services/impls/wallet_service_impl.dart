import 'package:bounce_patient_app/src/modules/wallet/models/transaction_ref.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/interfaces/wallet_service.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';

class WalletServiceImpl implements IWalletService {
  final IApi _api;

  WalletServiceImpl({required IApi api}) : _api = api;

  @override
  Future<void> confirmTopUp(TransactionRef ref) async {
    // TODO: implement confirmTopUp
    throw UnimplementedError();
  }

  @override
  Future<double> getBalance() async {
    // TODO: implement getBalance
    throw UnimplementedError();
  }

  @override
  Future<TransactionRef> topUp(double amount) async {
    // TODO: implement topUp
    throw UnimplementedError();
  }
}
