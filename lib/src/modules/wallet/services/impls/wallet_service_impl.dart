import 'package:bounce_patient_app/src/modules/wallet/models/transaction_ref.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/impls/api_urls.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/interfaces/wallet_service.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';

class WalletServiceImpl implements IWalletService {
  final IApi _api;

  WalletServiceImpl({required IApi api}) : _api = api;

  @override
  Future<void> confirmTopUp(TransactionRef ref) async {
    var url = WalletApiURLS.confirmTopUp + '?TxRef=${ref.value}';

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
  Future<double> getBalance() async {
    try {
      final response = await _api.get(WalletApiURLS.getBalance);
      return response['data']['balance'].toDouble();
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }

  @override
  Future<TransactionRef> initiateTopUp(double amount) async {
    var body = {"amount": amount.toInt()};

    try {
      final response = await _api.post(WalletApiURLS.topUp, body: body);
      return TransactionRef(value: response['data']['trxRef']);
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }
}
