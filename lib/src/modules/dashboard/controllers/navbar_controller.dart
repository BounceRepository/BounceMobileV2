import 'package:bounce_patient_app/src/modules/appointment/screens/appointment_screen.dart';
import 'package:bounce_patient_app/src/modules/chat/screens/room_screen.dart';
import 'package:bounce_patient_app/src/modules/dashboard/models/navbar_item.dart';
import 'package:bounce_patient_app/src/modules/dashboard/screens/home_screen.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:flutter/cupertino.dart';

class NavbarController extends ChangeNotifier {
  final _items = [
    NavbarItem(
      label: 'Home',
      icon: DashboardIcons.home,
      selected: true,
      screen: const HomeScreen(),
    ),
    NavbarItem(
      label: 'Appointment',
      icon: DashboardIcons.appointment,
      screen: const AppointmentsScreen(),
    ),
    NavbarItem(
      label: 'Measure',
      icon: DashboardIcons.measure,
      screen: const HomeScreen(),
    ),
    NavbarItem(
      label: 'Room',
      icon: DashboardIcons.people,
      screen: const RoomScreen(),
    ),
  ];
  List<NavbarItem> get items => _items;

  NavbarItem get selectedItem {
    final item = items.firstWhere((element) => element.selected);
    return item;
  }

  void onItemTapped(int index) {
    if (items.isNotEmpty) {
      final item = items[index];
      item.selected = true;
      unSelectOthersExcept(index);
      notifyListeners();
    }
  }

  void unSelectOthersExcept(int index) {
    final selectedItem = items[index];

    for (var item in items) {
      if (item != selectedItem) {
        item.selected = false;
      }
    }
  }
}