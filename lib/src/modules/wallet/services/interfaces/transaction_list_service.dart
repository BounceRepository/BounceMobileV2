import 'package:bounce_patient_app/src/modules/wallet/models/transaction.dart';

abstract class ITransactionListService {
  Future<List<Transaction>> getAll();
  Future<List<Transaction>> getAllTopUp();
  Future<List<Transaction>> getAllPayment();
}
