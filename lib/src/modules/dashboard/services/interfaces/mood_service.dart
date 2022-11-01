import 'package:bounce_patient_app/src/modules/dashboard/models/mood.dart';

abstract class IMoodService {
  Future<void> saveUserMoodListToDB(List<Mood> moods);
  Future<List<Mood>> getAllUserMood();
}
