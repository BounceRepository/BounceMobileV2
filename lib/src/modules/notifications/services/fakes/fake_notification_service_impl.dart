import 'dart:math';

import 'package:bounce_patient_app/src/modules/notifications/models/notification.dart';
import 'package:bounce_patient_app/src/modules/notifications/models/notification_list_response.dart';
import 'package:bounce_patient_app/src/modules/notifications/services/interfaces/notification_service.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class FakeNotificationServiceImpl implements INotificationService {
  @override
  Future<NotificationListResponse> getAllNotification() async {
    await fakeNetworkDelay();
    final notifications = List.generate(
      10,
      (index) => NotificationMessage(
        id: Random().nextInt(1000),
        title: lorem(paragraphs: 1, words: 5),
        body: lorem(paragraphs: 1, words: 25),
        createdAt: DateTime.now(),
        isRead: Random().nextBool(),
      ),
    );

    return NotificationListResponse(
      notifications: notifications,
      unReadNotificationCount: 5,
    );
  }

  @override
  Future<void> updateToken() async {
    await fakeNetworkDelay();
  }
  
  @override
  Future<void> readNotification() async {
    await fakeNetworkDelay();
  }
}
