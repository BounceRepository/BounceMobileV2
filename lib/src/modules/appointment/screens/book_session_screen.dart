import 'package:bounce_patient_app/src/modules/appointment/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/appointment/screens/screens.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookSessionScreen extends StatelessWidget {
  const BookSessionScreen({Key? key, required this.therapist}) : super(key: key);

  final Therapist therapist;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const CustomAppBar(label: 'Book Session'),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 24.h),
              const BookingTabBar(),
              Expanded(
                child: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    BookingScheduleView(therapist: therapist),
                    BookingConfirmationView(therapist: therapist),
                    BookingPaymentView(therapist: therapist),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookingTabBar extends StatelessWidget {
  const BookingTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labelStyle = AppText.bold500(context).copyWith(
      fontSize: 14.sp,
    );

    return SizedBox(
      height: 38.h,
      child: TabBar(
        labelColor: AppColors.lightText,
        unselectedLabelColor: AppColors.lightText,
        indicatorColor: AppColors.primary,
        labelStyle: labelStyle,
        unselectedLabelStyle: labelStyle,
        tabs: const [
          Tab(text: 'Schedule'),
          Tab(text: 'Confirmation'),
          Tab(text: 'Payment'),
        ],
      ),
    );
  }
}
