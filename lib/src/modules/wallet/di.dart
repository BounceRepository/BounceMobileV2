import 'package:bounce_patient_app/src/config/di_container.dart';
import 'package:bounce_patient_app/src/modules/wallet/controllers/transaction_list_controller.dart';
import 'package:bounce_patient_app/src/modules/wallet/controllers/wallet_controller.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/fakes/fake_transaction_list_service_impl.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/fakes/fake_wallet_service_impl.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/impls/wallet_service_impl.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/interfaces/wallet_service.dart';

import 'services/impls/transaction_list_service_impl.dart';
import 'services/interfaces/transaction_list_service.dart';

void walletControllersInit({required bool useFake}) {
  if (useFake) {
    diContainer.registerFactory(() => TransactionListController(
        transactionListService: FakeTransactionListServiceImpl()));
    diContainer
        .registerFactory(() => WalletController(walletService: FakeWalletServiceImpl()));
  } else {
    diContainer.registerFactory(
        () => TransactionListController(transactionListService: diContainer()));
    diContainer.registerFactory(() => WalletController(walletService: diContainer()));
  }
}

void walletServicesInit() {
  diContainer.registerLazySingleton<ITransactionListService>(
      () => TransactionListServiceImpl(api: diContainer()));
  diContainer
      .registerLazySingleton<IWalletService>(() => WalletServiceImpl(api: diContainer()));
}