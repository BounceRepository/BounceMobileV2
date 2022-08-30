import 'package:bounce_patient_app/src/modules/dashboard/controllers/navbar_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late NavbarController sut;

  setUp(() {
    sut = NavbarController();
  });

  group('NavbarController.OnItemTapped', () {
    test('should select selected item', () {
      //set up

      //act

      // select 2nd item in the list
      sut.onItemTapped(1);

      //assert
      expect(sut.items[1].selected, true);
    });

    test('should unselect previous selected item', () {
      //set up

      //act

      // select 2nd item in the list
      sut.onItemTapped(1);

      //assert
      expect(sut.items[1].selected, true);
      expect(sut.items[0].selected, false);
    });
  });
}
