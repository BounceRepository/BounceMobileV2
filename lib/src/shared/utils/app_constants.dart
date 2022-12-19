import 'package:bounce_patient_app/src/shared/assets/images.dart';

class AppConstants {
  AppConstants._();

  static String nairaSymbol = "\u{20A6}";
  static const flutterwavePublicKey = 'FLWPUBK_TEST-4790120d89233b62d9c5f6e0a7437c9d-X';
  static const states = [
    'Abia',
    'Adamawa',
    'Akwa Ibom',
    'Anambra',
    'Bauchi',
    'Bayelsa',
    'Benue',
    'Borno',
    'Cross River',
    'Delta',
    'Ebonyi',
    'Edo',
    'Ekiti',
    'Enugu',
    'Gombe',
    'Imo',
    'Jigawa',
    'Kaduna',
    'Kano',
    'Katsina',
    'Kebbi',
    'Kogi',
    'Kwara',
    'Lagos',
    'Nasarawa',
    'Niger',
    'Ogun',
    'Ondo',
    'Osun',
    'Oyo',
    'Plateau',
    'Rivers',
    'Sokoto',
    'Taraba',
    'Yobe',
    'Zamfara',
    'FCT',
  ];

  static const moods = [
    'calm',
    'angry',
    'happy',
    'sad',
    'mood swings',
    'lonely',
    'stressed',
    'depressed',
    'nostalgia',
    'guilt',
    'delusional',
    'paranoia',
    'relief',
    'anxious',
    'love',
    'disgust',
    'contempt',
    'suprise',
    'confused',
    'elated',
    'satisfied',
  ];
  static const moodIcons = [
    MoodIcons.calm,
    MoodIcons.angry,
    MoodIcons.happy,
    MoodIcons.manic,
  ];
  static const agoraAppId = '';
  static const emailPref = "emailPref";
  static const userNamePref = 'userNamePref';
}

Future<void> fakeNetworkDelay({int seconds = 2}) async {
  await Future.delayed(Duration(seconds: seconds));
}

enum WeekDays {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}
