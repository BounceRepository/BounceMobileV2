import 'package:bounce_patient_app/src/modules/wallet/models/transaction.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/interfaces/transaction_list_service.dart';
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
    // TODO: implement getAllTopUp
    throw UnimplementedError();
  }
}
