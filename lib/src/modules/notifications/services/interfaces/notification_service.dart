import 'package:bounce_patient_app/src/modules/notifications/models/notification.dart';

abstract class INotificationService {
  Future<List<NotificationMessage>> getAllNotification();
  Future<void> updateToken();
}
