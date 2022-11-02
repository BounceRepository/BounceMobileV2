import 'package:bounce_patient_app/src/modules/notifications/models/notification.dart';

class NotificationListResponse {
  final int unReadNotificationCount;
  final List<NotificationMessage> notifications;

  NotificationListResponse({
    required this.unReadNotificationCount,
    required this.notifications,
  });

  factory NotificationListResponse.fromJson(Map<String, dynamic> json) {
    return NotificationListResponse(
      unReadNotificationCount: json['total'] - json['totalOpenNotifcation'],
      notifications: List<NotificationMessage>.from(
        (json['records'] as List<int>).map<NotificationMessage>(
          (x) => NotificationMessage.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  Map<String, dynamic> toJsonp() {
    return <String, dynamic>{
      'unReadNotificationCount': unReadNotificationCount,
      'notifications': notifications.map((x) => x.toJson()).toList(),
    };
  }
}
