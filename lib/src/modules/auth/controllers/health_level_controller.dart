import 'package:bounce_patient_app/src/modules/auth/models/health_level.dart';
import 'package:bounce_patient_app/src/shared/helper_functions/helper_functions.dart';
import 'package:flutter/cupertino.dart';

class PhysicalHealthLevelController extends HealthLevelController {}

class MentalHealthLevelController extends HealthLevelController {}

class EmotionalHealthLevelController extends HealthLevelController {}

class EatingHabitLevelController extends HealthLevelController {}

class HealthLevelController extends ChangeNotifier {
  final List<HealthLevel> _options = [
    HealthLevel(
      id: Utils.generateUniqueId(),
      title: 'Not Good',
      isSelected: false,
    ),
    HealthLevel(
      id: Utils.generateUniqueId(),
      title: 'Good',
      isSelected: false,
    ),
    HealthLevel(
      id: Utils.generateUniqueId(),
      title: 'Great',
      isSelected: false,
    ),
    HealthLevel(
      id: Utils.generateUniqueId(),
      title: 'Perfect',
      isSelected: false,
    ),
  ];
  List<HealthLevel> get healthLevelList => _options;
  HealthLevel? selectedHealthLevel;

  void init() {
    selectedHealthLevel = null;
  }

  void select(HealthLevel healthLevel) {
    for (var level in _options) {
      if (level.id == healthLevel.id) {
        level.isSelected = true;
      }
    }
    selectedHealthLevel = healthLevel;
    _unselectOthersExcept(healthLevel);
    notifyListeners();
  }

  void _unselectOthersExcept(HealthLevel healthLevel) {
    for (var level in _options) {
      if (level.id != healthLevel.id) {
        level.isSelected = false;
      }
    }
  }
}
