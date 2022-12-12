import 'package:bounce_patient_app/src/config/app_config.dart';

class WalletApiURLS {
  WalletApiURLS._();

  static const getBalance = APIURLs.baseURL + '/transaction/GetWalletBalance';
  static const topUp = APIURLs.baseURL + '/transaction/WalletTop';
  static const confirmTopUp = APIURLs.baseURL + '/transaction/ComfirmTopUp';

  // Transactions
  static const getAllTransaction =
      APIURLs.baseURL + '/transaction/GetTransactionHistory?filter=all';
  static const getAllTopUpTransaction =
      APIURLs.baseURL + '/transaction/GetTransactionHistory?filter=topup';
  static const getAllPaymentTransactionList =
      APIURLs.baseURL + '/transaction/GetTransactionHistory?filter=payment';
}

class PaymentApiURLS {
  PaymentApiURLS._();

  static const initiate = APIURLs.baseURL + '/transaction/PaymentRequest';
  static const confirm = APIURLs.baseURL + '/transaction/PaymentRequery';
  static const payWithWallet = APIURLs.baseURL + '/transaction/PaymentWithWallet';
}
