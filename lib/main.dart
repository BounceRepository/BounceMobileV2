// ignore_for_file: library_prefixes

import 'package:bounce_patient_app/src/config/notification_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bounce_patient_app/src/app.dart';
import 'package:bounce_patient_app/src/config/di_container.dart' as diContainer;
import 'package:just_audio_background/just_audio_background.dart';

void main() async {
  await diContainer.init();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(const ThriveXApp());
  });
}
