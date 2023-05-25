import 'package:bounce_patient_app/src/config/app_config.dart';

class NotificationApiURLS {
  NotificationApiURLS._();

  static String getAllNotification = '${APIURLs.baseURL}/Notification/GetAllUserNotifications';
  static String updateToken = '${APIURLs.baseURL}/Notification/UpdateNotificationToken';
  static String markAsRead = '${APIURLs.baseURL}/Notification/ReadNotification';
}
