import 'package:bounce_patient_app/src/modules/dashboard/models/mood.dart';
import 'package:bounce_patient_app/src/modules/dashboard/services/interfaces/mood_service.dart';
import 'package:bounce_patient_app/src/shared/assets/images.dart';
import 'package:bounce_patient_app/src/shared/helper_functions/helper_functions.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class FakeMoodServiceImpl implements IMoodService {
  @override
  Future<List<Mood>> getAllUserMood() async {
    await fakeNetworkDelay();
    return List.generate(8, (index) => _mood);
  }

  @override
  Future<void> saveUserMoodListToDB(List<Mood> moods) async {
    await fakeNetworkDelay();
  }
}

final _mood = Mood(
  id: Utils.getGuid(),
  icon: MoodIcons.calm,
  name: lorem(paragraphs: 1, words: 1),
);
