import 'package:bounce_patient_app/src/config/app_config.dart';

class WalletApiURLS {
  WalletApiURLS._();

  static String getBalance = '${APIURLs.baseURL}/transaction/GetWalletBalance';
  static String topUp = '${APIURLs.baseURL}/transaction/WalletTop';
  static String confirmTopUp = '${APIURLs.baseURL}/transaction/ComfirmTopUp';

  // Transactions
  static String getAllTransaction = '${APIURLs.baseURL}/transaction/GetTransactionHistory?filter=all';
  static String getAllTopUpTransaction = '${APIURLs.baseURL}/transaction/GetTransactionHistory?filter=topup';
  static String getAllPaymentTransactionList = '${APIURLs.baseURL}/transaction/GetTransactionHistory?filter=payment';
}

class PaymentApiURLS {
  PaymentApiURLS._();

  static String initiate = '${APIURLs.baseURL}/transaction/PaymentRequest';
  static String confirm = '${APIURLs.baseURL}/transaction/PaymentRequery';
  static String payWithWallet = '${APIURLs.baseURL}/transaction/PaymentWithWallet';
}
