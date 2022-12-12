import 'package:bounce_patient_app/src/config/app_config.dart';

class WalletApiURLS {
  WalletApiURLS._();

  static const getAllTransaction =
      APIURLs.baseURL + '/transaction/WalletTransactionHistory';
  static const getBalance = APIURLs.baseURL + '/transaction/GetWalletBalance';
  static const topUp = APIURLs.baseURL + '/transaction/WalletTop';
  static const confirmTopUp = APIURLs.baseURL + '/transaction/ComfirmTopUp';
  static const getTopUpTransactionList =
      APIURLs.baseURL + '/transaction/GetTransactionHistory';
}

class PaymentApiURLS {
  PaymentApiURLS._();

  static const initiate = APIURLs.baseURL + '/transaction/PaymentRequest';
  static const confirm = APIURLs.baseURL + '/transaction/PaymentRequery';
  static const payWithWallet = APIURLs.baseURL + '/transaction/PaymentWithWallet';
}
