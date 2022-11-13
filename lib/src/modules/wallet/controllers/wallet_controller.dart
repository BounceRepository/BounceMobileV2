import 'package:bounce_patient_app/src/modules/wallet/models/transaction_ref.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/interfaces/wallet_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

class WalletController extends BaseController {
  final IWalletService _walletService;

  WalletController({required IWalletService walletService})
      : _walletService = walletService;

  double _balance = 0.0;
  double get balance => _balance;

  Future<void> getBalance() async {
    try {
      _balance = await _walletService.getBalance();
      notifyListeners();
    } on Failure {
      rethrow;
    }
  }

  Future<TransactionRef> topUp(double amount) async {
    try {
      return await _walletService.topUp(amount);
    } on Failure {
      rethrow;
    }
  }

  Future<void> confirmTopUp(TransactionRef txRef) async {
    try {
      await _walletService.confirmTopUp(txRef);
    } on Failure {
      rethrow;
    }
  }
}
