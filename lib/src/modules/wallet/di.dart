import 'package:bounce_patient_app/src/config/di_container.dart';
import 'package:bounce_patient_app/src/modules/wallet/controllers/payment_controller.dart';
import 'package:bounce_patient_app/src/modules/wallet/controllers/transaction_list_controller.dart';
import 'package:bounce_patient_app/src/modules/wallet/controllers/wallet_controller.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/fakes/fake_payment_service_impl.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/fakes/fake_transaction_list_service_impl.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/fakes/fake_wallet_service_impl.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/impls/payment_service_impl.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/impls/wallet_service_impl.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/interfaces/payment_service.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/interfaces/wallet_service.dart';

import 'services/impls/transaction_list_service_impl.dart';
import 'services/interfaces/transaction_list_service.dart';

void walletControllersInit({required bool useFake}) {
  if (useFake) {
    diContainer.registerFactory(() => TransactionListController(transactionListService: FakeTransactionListService()));
    diContainer.registerFactory(() => WalletController(walletService: FakeWalletService()));
    diContainer.registerFactory(() => PaymentController(paymentService: FakePaymentService()));
  } else {
    diContainer.registerFactory(() => TransactionListController(transactionListService: diContainer()));
    diContainer.registerFactory(() => WalletController(walletService: diContainer()));
    diContainer.registerFactory(() => PaymentController(paymentService: diContainer()));
  }
}

void walletServicesInit() {
  diContainer.registerLazySingleton<ITransactionListService>(() => TransactionListService(api: diContainer()));
  diContainer.registerLazySingleton<IWalletService>(() => WalletService(api: diContainer()));
  diContainer.registerLazySingleton<IPaymentService>(() => PaymentService(api: diContainer()));
}
