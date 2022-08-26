import 'package:bounce_patient_app/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bounce_patient_app/src/config/service_locator.dart' as service_locator;

void main() async {
  await service_locator.init();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(const MyApp());
  });
}
