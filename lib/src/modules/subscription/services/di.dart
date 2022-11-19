import 'package:bounce_patient_app/src/config/di_container.dart';
import 'package:bounce_patient_app/src/modules/subscription/controllers/subscription_list_controller.dart';
import 'package:bounce_patient_app/src/modules/subscription/services/fakes/fake_subscription_service_impl.dart';
import 'package:bounce_patient_app/src/modules/subscription/services/impls/subscription_service_impl.dart';
import 'package:bounce_patient_app/src/modules/subscription/services/interfaces/subscription_service.dart';

void subscriptionControllersInit({required bool useFake}) {
  if (useFake) {
    diContainer.registerFactory(() =>
        SubscriptionListController(subscriptionService: FakeSubscriptionServiceImpl()));
  } else {
    diContainer.registerFactory(
        () => SubscriptionListController(subscriptionService: diContainer()));
  }
}

void subscriptionServicesInit() {
  diContainer.registerLazySingleton<ISubscriptionService>(
      () => SubscriptionServiceImpl(api: diContainer()));
}
