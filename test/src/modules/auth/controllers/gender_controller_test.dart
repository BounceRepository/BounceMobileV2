import 'package:bounce_patient_app/src/modules/auth/controllers/gender_controller.dart';
import 'package:bounce_patient_app/src/shared/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GenderController sut;

  setUp(() {
    sut = GenderController();
  });

  group('GenderController.Select', () {
    test('should select a gender type', () {
      //setup

      //act
      sut.select(GenderType.female);

      //assert
      expect(sut.genders[1].isSelected, true);
    });

    test('should unselect other gender type after selecting a new gender', () {
      //setup

      //act
      sut.select(GenderType.female);

      //assert
      expect(sut.genders[0].isSelected, false);
      expect(sut.genders[1].isSelected, true);
    });
  });
}
