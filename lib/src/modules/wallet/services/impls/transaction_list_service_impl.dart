import 'package:bounce_patient_app/src/modules/wallet/models/transaction.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/impls/api_urls.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/interfaces/transaction_list_service.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';

class TransactionListServiceImpl implements ITransactionListService {
  final IApi _api;

  TransactionListServiceImpl({required IApi api}) : _api = api;

  @override
  Future<List<Transaction>> getAll() async {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<List<Transaction>> getAllPayment() async {
    // TODO: implement getAllPayment
    throw UnimplementedError();
  }

  @override
  Future<List<Transaction>> getAllTopUp() async {
    try {
      final response = await _api.get(WalletApiURLS.getTopUpTransactionList);
      final List collection = response['data'];
      return collection.map((json) => Transaction.fromJson(json)).toList();
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }
}
