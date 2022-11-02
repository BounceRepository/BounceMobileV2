import 'dart:math';

import 'package:bounce_patient_app/src/modules/notifications/models/notification.dart';
import 'package:bounce_patient_app/src/modules/notifications/services/interfaces/notification_service.dart';
import 'package:bounce_patient_app/src/shared/helper_functions/helper_functions.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class FakeNotificationServiceImpl implements INotificationService {
  @override
  Future<List<NotificationMessage>> getAllNotification() async {
    await fakeNetworkDelay();
    return List.generate(
      10,
      (index) => NotificationMessage(
        id: Utils.getGuid(),
        title: lorem(paragraphs: 1, words: 5),
        body: lorem(paragraphs: 1, words: 25),
        createdAt: DateTime.now(),
        isRead: Random().nextBool(),
      ),
    );
  }

  @override
  Future<void> updateToken() async {
    await fakeNetworkDelay();
  }
}
