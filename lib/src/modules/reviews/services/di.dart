import 'package:bounce_patient_app/src/config/di_container.dart';
import 'package:bounce_patient_app/src/modules/reviews/controllers/review_controller.dart';
import 'package:bounce_patient_app/src/modules/reviews/services/fakes/fake_review_service_impl.dart';
import 'package:bounce_patient_app/src/modules/reviews/services/impls/review_service_impl.dart';
import 'package:bounce_patient_app/src/modules/reviews/services/interfaces/i_review_service.dart';

void reviewControllersInit({required bool useFake}) {
  if (useFake) {
    diContainer.registerFactory(() => ReviewController(reviewService: FakeReviewService()));
  } else {
    diContainer.registerFactory(() => ReviewController(reviewService: diContainer()));
  }
}

void reviewServicesInit() {
  diContainer.registerLazySingleton<IReviewService>(() => ReviewService(api: diContainer()));
}
