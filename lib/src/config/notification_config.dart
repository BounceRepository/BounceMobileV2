import 'dart:developer';

import 'package:bounce_patient_app/src/shared/utils/messenger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

/// Receive message when app is in background
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final notification = message.notification;

  if (notification != null) {
    // // Save notification details to firestore
    // if (message.data['type'] == 'messages') {
    //   final newNotification = NotificationMessage(
    //     title: notification.title!,
    //     body: notification.body!,
    //     createdAt: DateTime.now(),
    //     read: false,
    //   );

    //   notificationRef.add(newNotification);
    // }
  }
}

class NotificationConfig extends StatefulWidget {
  const NotificationConfig({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<NotificationConfig> createState() => _NotificationConfigState();
}

class _NotificationConfigState extends State<NotificationConfig> {
  @override
  void initState() {
    super.initState();
    listenForFirebaseMessagingNotifications();
  }

  void listenForFirebaseMessagingNotifications() async {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) => handleMessage(message),
    );
  }

  void handleMessage(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    if (notification != null && android != null) {
      final title = notification.title;
      final body = notification.body;

      if (title != null && body != null) {
        log(title);
        Messenger.info(
          title: title,
          message: body,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
