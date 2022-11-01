import 'package:bounce_patient_app/src/config/app_config.dart';

class MoodApiURLS {
  MoodApiURLS._();

  static const getAllUserMood = APIURLs.baseURL + '/Patient/GetAllFeelings';
  static const saveUserMoodListToDB = APIURLs.baseURL + '/Patient/LogUserfeelings';
}
