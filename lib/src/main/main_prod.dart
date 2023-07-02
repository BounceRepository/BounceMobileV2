import 'package:bounce_patient_app/src/app.dart';
import 'package:bounce_patient_app/src/config/app_config.dart';
import 'package:bounce_patient_app/src/config/locator/di_global.dart';
import 'package:bounce_patient_app/src/config/locator/di_prod.dart';
import 'package:bounce_patient_app/src/config/providers_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio_background/just_audio_background.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    final config = AppConfig(
      appEnvironment: AppEnvironment.prod,
      appName: 'ThriveX',
      diContainer: prodLocator,
      baseUrl: '',
    );
    initGlobalDI(envLocator: config.diContainer);
    initContainers(appConfig: config);
    runApp(const ProvidersWrapper(child: ThriveXApp()));
  });
}
