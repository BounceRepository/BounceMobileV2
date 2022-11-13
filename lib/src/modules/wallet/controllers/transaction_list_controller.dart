import 'package:bounce_patient_app/src/modules/wallet/models/transaction.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/interfaces/transaction_list_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

class TransactionListController extends BaseController {
  final ITransactionListService _transactionListService;

  TransactionListController({required ITransactionListService transactionListService})
      : _transactionListService = transactionListService;

  List<Transaction> _transactions = [];
  List<Transaction> get transactions => _transactions;
  List<Transaction> _topUptransactions = [];
  List<Transaction> get topUTtransactions => _topUptransactions;
  List<Transaction> _paymenttransactions = [];
  List<Transaction> get paymentTransactions => _paymenttransactions;

  Future<void> getAll() async {
    try {
      _transactions = await _transactionListService.getAll();
    } on Failure {
      rethrow;
    }
  }

  Future<void> getAllPayment() async {
    try {
      _paymenttransactions = await _transactionListService.getAllPayment();
    } on Failure {
      rethrow;
    }
  }

  Future<void> getAllTopUp() async {
    try {
      _topUptransactions = await _transactionListService.getAllTopUp();
    } on Failure {
      rethrow;
    }
  }
}
