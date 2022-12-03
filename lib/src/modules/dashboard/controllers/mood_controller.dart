import 'package:bounce_patient_app/src/modules/dashboard/models/mood.dart';
import 'package:bounce_patient_app/src/modules/dashboard/services/interfaces/mood_service.dart';
import 'package:bounce_patient_app/src/shared/assets/images.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/utils/utils.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';

class MoodController extends BaseController {
  final IMoodService _moodService;

  MoodController({required IMoodService moodService}) : _moodService = moodService;

  final moodList = List.generate(
    AppConstants.moods.length,
    (index) {
      final mood = AppConstants.moods[index];
      return Mood(
        id: Utils.getGuid(),
        icon: index < 4 ? AppConstants.moodIcons[index] : MoodIcons.calm,
        name: mood,
      );
    },
  );

  List<Mood> _userMoodList = [];
  List<Mood> get userMoodList => _userMoodList;
  List<Mood> _selectedMoodList = [];
  List<Mood> get selectedMoodList => _selectedMoodList;

  void select(Mood mood) {
    for (var element in moodList) {
      if (element.id == mood.id) {
        element.isSelected = !element.isSelected;
      }
    }
    notifyListeners();
  }

  Future<void> getAllUserMood() async {
    try {
      setIsLoading(true);
      _userMoodList = await _moodService.getAllUserMood();
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }

  Future<void> saveSelectedMoodListToDB() async {
    _selectedMoodList = moodList.where((element) => element.isSelected).toList();

    try {
      setIsLoading(true);
      await _moodService.saveUserMoodListToDB(selectedMoodList);
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }
}
