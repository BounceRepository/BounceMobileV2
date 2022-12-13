import 'package:bounce_patient_app/src/modules/notifications/models/notification.dart';
import 'package:bounce_patient_app/src/modules/notifications/services/interfaces/notification_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

class NotificationController extends BaseController {
  final INotificationService _notificationService;

  NotificationController({required INotificationService notificationService})
      : _notificationService = notificationService;

  int unReadNotificationCount = 0;
  List<NotificationMessage> _notifications = [];
  List<NotificationMessage> get notifications => _notifications;

  Future<void> getAllNotification() async {
    reset();
    try {
      final response = await _notificationService.getAllNotification();
      unReadNotificationCount = response.unReadNotificationCount;
      _notifications = response.notifications;
      notifyListeners();
    } on Failure {
      rethrow;
    }
  }

  Future<void> updateToken() async {
    try {
      await _notificationService.updateToken();
    } on Failure {
      rethrow;
    }
  }

  Future<void> readNotifications() async {
    try {
      await _notificationService.readNotification();
      _markAsRead();
    } on Failure {
      rethrow;
    }
  }

  void _markAsRead() {
    for (final element in notifications) {
      element.isRead = true;
    }
    unReadNotificationCount = 0;
    notifyListeners();
  }

  void clear() {
    unReadNotificationCount = 0;
    _notifications.clear();
  }

  void resetUnreadCount() {
    unReadNotificationCount = 0;
    notifyListeners();
  }
}
