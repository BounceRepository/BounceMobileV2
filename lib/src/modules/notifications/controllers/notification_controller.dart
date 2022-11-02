import 'package:bounce_patient_app/src/modules/notifications/models/notification.dart';
import 'package:bounce_patient_app/src/modules/notifications/services/interfaces/notification_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

class NotificationController extends BaseController {
  final INotificationService _notificationService;

  NotificationController({required INotificationService notificationService})
      : _notificationService = notificationService;

  List<NotificationMessage> _notifications = [];
  List<NotificationMessage> get notifications => _notifications;

  Future<void> getAllNotification() async {
    try {
      setIsLoading(true);
      _notifications = await _notificationService.getAllNotification();
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
}
