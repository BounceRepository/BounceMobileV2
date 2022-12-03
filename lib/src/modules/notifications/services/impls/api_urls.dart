import 'package:bounce_patient_app/src/config/app_config.dart';

class NotificationApiURLS {
  NotificationApiURLS._();

  static const getAllNotification =
      APIURLs.baseURL + '/Notification/GetAllUserNotifications';
  static const updateToken = APIURLs.baseURL + '/Notification/UpdateNotificationToken';
  static const markAsRead = APIURLs.baseURL + '/Notification/ReadNotification';
}
