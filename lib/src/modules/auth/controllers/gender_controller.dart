import 'package:bounce_patient_app/src/shared/models/user.dart';
import 'package:flutter/cupertino.dart';

class GenderController extends ChangeNotifier {
  Gender selectedGender = Gender(type: GenderType.male, isSelected: true);
  final List<Gender> _genders = [
    Gender(type: GenderType.male, isSelected: true),
    Gender(type: GenderType.female),
  ];
  List<Gender> get genders => _genders;

  void select(GenderType type) {
    if (genders.isNotEmpty) {
      genders.firstWhere((element) => element.type == type).isSelected = true;
      _unSelectOthersUntil(type);
      notifyListeners();
    }
  }

  void _unSelectOthersUntil(GenderType type) {
    for (var item in genders) {
      if (item.type != type) {
        item.isSelected = false;
      }
    }
  }
}
