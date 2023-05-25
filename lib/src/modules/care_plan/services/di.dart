import 'package:bounce_patient_app/src/config/di_container.dart';
import 'package:bounce_patient_app/src/modules/care_plan/controllers/care_plan_controller.dart';
import 'package:bounce_patient_app/src/modules/care_plan/services/fakes/fake_care_plan_service_impl.dart';
import 'package:bounce_patient_app/src/modules/care_plan/services/impls/care_plan_service_impl.dart';
import 'package:bounce_patient_app/src/modules/care_plan/services/interfaces/care_plan_service.dart';

void subscriptionControllersInit({required bool useFake}) {
  if (useFake) {
    diContainer.registerFactory(() => CarePlanController(subscriptionService: FakeCarePlanService()));
  } else {
    diContainer.registerFactory(() => CarePlanController(subscriptionService: diContainer()));
  }
}

void subscriptionServicesInit() {
  diContainer.registerLazySingleton<ICarePlanService>(() => CarePlanService(api: diContainer()));
}
