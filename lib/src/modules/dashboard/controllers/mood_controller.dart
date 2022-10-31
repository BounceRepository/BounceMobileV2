import 'package:bounce_patient_app/src/modules/dashboard/models/mood.dart';
import 'package:bounce_patient_app/src/shared/assets/images.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/helper_functions/helper_functions.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';

class MoodController extends BaseController {
  final moods = List.generate(
    AppConstants.moods.length,
    (index) {
      final mood = AppConstants.moods[index];
      return Mood(
        id: Utils.generateUniqueId(),
        icon: MoodIcons.calm,
        name: mood,
      );
    },
  );

  void select(Mood mood) {
    for (var element in moods) {
      if (element.id == mood.id) {
        element.isSelected = !element.isSelected;
      }
    }
    notifyListeners();
  }
}
