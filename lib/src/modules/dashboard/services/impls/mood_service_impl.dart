import 'package:bounce_patient_app/src/modules/dashboard/models/mood.dart';
import 'package:bounce_patient_app/src/modules/dashboard/services/impls/api_urls.dart';
import 'package:bounce_patient_app/src/modules/dashboard/services/interfaces/mood_service.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';

class MoodService implements IMoodService {
  final IApi _api;

  MoodService({required IApi api}) : _api = api;

  @override
  Future<List<Mood>> getAllUserMood() async {
    try {
      final response = await _api.get(MoodApiURLS.getAllUserMood);
      final List collection = response['data'];
      return collection.map((json) => Mood.fromJson(json)).toList();
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }

  @override
  Future<void> saveUserMoodListToDB(List<Mood> moods) async {
    final body = moods.map((e) => e.name).toList();

    try {
      await _api.post(MoodApiURLS.saveUserMoodListToDB, body: body);
    } on Failure {
      rethrow;
    }
  }
}
