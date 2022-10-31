import 'package:bounce_patient_app/src/modules/account/screens/account_screen.dart';
import 'package:bounce_patient_app/src/modules/appointment/screens/screens.dart';
import 'package:bounce_patient_app/src/modules/chat/screens/rant_room_screen.dart';
import 'package:bounce_patient_app/src/modules/dashboard/screens/home_screen.dart';
import 'package:bounce_patient_app/src/modules/playlist/screens/playlist_list_screen.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key, this.selectedIndex = 0}) : super(key: key);

  final int selectedIndex;

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late int _selectedIndex = widget.selectedIndex;
  static const screens = <Widget>[
    HomeScreen(),
    TherapistListScreen(),
    PlayListScreen(),
    RoomScreen(),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = AppText.bold600(context).copyWith(fontSize: 8.sp);

    return Scaffold(
      body: screens.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(top: 20.h, bottom: 9.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(.11),
              offset: const Offset(0, 4),
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            _navigationBarItem(
              icon: DashboardIcons.home,
              label: 'Home',
            ),
            _navigationBarItem(
              icon: DashboardIcons.appointment,
              label: 'Therapists',
            ),
            _navigationBarItem(
              icon: DashboardIcons.music,
              label: 'Music',
            ),
            _navigationBarItem(
              icon: DashboardIcons.chat,
              label: 'Chat',
            ),
            _navigationBarItem(
              icon: DashboardIcons.account,
              label: 'Account',
            ),
          ],
          currentIndex: _selectedIndex,
          backgroundColor: Colors.white,
          elevation: 0,
          selectedLabelStyle: labelStyle.copyWith(
            color: AppColors.primary,
          ),
          unselectedLabelStyle: labelStyle.copyWith(
            color: AppColors.border,
          ),
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  BottomNavigationBarItem _navigationBarItem({
    required String icon,
    required String label,
  }) {
    final iconSize = 24.h;

    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: SvgPicture.asset(
          icon,
          color: AppColors.border,
          height: iconSize,
          width: iconSize,
        ),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: SvgPicture.asset(
          icon,
          color: AppColors.primary,
          height: iconSize,
          width: iconSize,
        ),
      ),
      label: label,
    );
  }
}
