// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bounce_patient_app/src/app.dart';
import 'package:bounce_patient_app/src/config/di_container.dart' as diContainer;

void main() async {
  await diContainer.init();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(const BouncePatientApp());
  });
}
