import 'package:bounce_patient_app/src/modules/wallet/models/transaction.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/interfaces/transaction_list_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

class TransactionListController extends BaseController {
  final ITransactionListService _transactionListService;

  TransactionListController({required ITransactionListService transactionListService})
      : _transactionListService = transactionListService;

  List<Transaction> _allTransactions = [];
  List<Transaction> get allTransactions => _allTransactions;
  List<Transaction> _topUptransactions = [];
  List<Transaction> get topUpTransactions => _topUptransactions;
  List<Transaction> _paymenttransactions = [];
  List<Transaction> get paymentTransactions => _paymenttransactions;

  Future<void> getAll() async {
    reset();
    try {
      _allTransactions = await _transactionListService.getAll();
      notifyListeners();
    } on Failure {
      rethrow;
    }
  }

  Future<void> getAllPayment() async {
    reset();
    try {
      _paymenttransactions = await _transactionListService.getAllPayment();
      notifyListeners();
    } on Failure {
      rethrow;
    }
  }

  Future<void> getAllTopUp() async {
    reset();
    try {
      _topUptransactions = await _transactionListService.getAllTopUp();
      notifyListeners();
    } on Failure {
      rethrow;
    }
  }

  void clear() {
    _allTransactions.clear();
    _paymenttransactions.clear();
    _topUptransactions.clear();
  }
}
