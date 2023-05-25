import 'package:bounce_patient_app/src/config/app_config.dart';

class MoodApiURLS {
  MoodApiURLS._();

  static String getAllUserMood = '${APIURLs.baseURL}/Patient/GetAllFeelings';
  static String saveUserMoodListToDB = '${APIURLs.baseURL}/Patient/LogUserfeelings';
}
