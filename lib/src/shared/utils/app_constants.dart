import 'package:bounce_patient_app/src/shared/assets/images.dart';

class AppConstants {
  AppConstants._();

  static String nairaSymbol = "\u{20A6}";
  static const flutterwavePublicKey = 'FLWPUBK_TEST-4790120d89233b62d9c5f6e0a7437c9d-X';
  static const states = [
    'Abia',
    'Bauchi',
    'Rivers',
    'Lagos',
    'Adamawa',
    'Abuja',
    'Ondo',
    'Ibadan',
    'Osun',
    'Sokoto',
    'Enugu',
    'Imo',
    'Kogi',
    'Kaduna',
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
}

Future<void> fakeNetworkDelay() async {
  await Future.delayed(const Duration(seconds: 2));
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
