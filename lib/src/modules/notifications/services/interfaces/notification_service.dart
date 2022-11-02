import 'package:bounce_patient_app/src/modules/notifications/models/notification.dart';
import 'package:bounce_patient_app/src/modules/notifications/models/notification_list_response.dart';

abstract class INotificationService {
  Future<NotificationListResponse> getAllNotification();
  Future<void> updateToken();
}
