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
    try {
      setIsLoading(true);
      final response = await _notificationService.getAllNotification();
      unReadNotificationCount = response.unReadNotificationCount;
      _notifications = response.notifications;
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
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

  void markAsRead() {
    for (final element in notifications) {
      element.isRead = true;
    }
    unReadNotificationCount = 0;
    notifyListeners();
  }
}
