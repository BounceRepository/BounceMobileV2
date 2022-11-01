import 'package:bounce_patient_app/src/config/di_container.dart';
import 'package:bounce_patient_app/src/modules/dashboard/controllers/mood_controller.dart';
import 'package:bounce_patient_app/src/modules/dashboard/services/fakes/fake_mood_service_impl.dart';

void moodControllersInit({
  required bool initFakeService,
}) {
  if (initFakeService) {
    diContainer.registerFactory(() => MoodController(moodService: FakeMoodServiceImpl()));
  } else {
    diContainer.registerFactory(() => MoodController(moodService: diContainer()));
  }
}