import 'package:bounce_patient_app/src/config/di_container.dart';
import 'package:bounce_patient_app/src/modules/notifications/controllers/notification_controller.dart';
import 'package:bounce_patient_app/src/modules/notifications/services/fakes/fake_notification_service_impl.dart';

void notificationControllersInit({
  required bool useFake,
}) {
  if (useFake) {
    diContainer.registerFactory(
        () => NotificationController(notificationService: FakeNotificationService()));
  } else {
    diContainer.registerFactory(
        () => NotificationController(notificationService: diContainer()));
  }
}
