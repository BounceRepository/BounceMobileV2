// ignore_for_file: library_prefixes

import 'package:bounce_patient_app/src/config/notification_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bounce_patient_app/src/app.dart';
import 'package:bounce_patient_app/src/config/di_container.dart' as diContainer;

void main() async {
  await diContainer.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(const BouncePatientApp());
  });
}
