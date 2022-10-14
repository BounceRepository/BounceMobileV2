import 'package:bounce_patient_app/src/modules/appointment/screens/screens.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_child_scrollview.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_star_rating.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/default_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookSessionScreen extends StatelessWidget {
  const BookSessionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(label: 'Book Session'),
      body: SafeArea(
        child: Center(
          child: CustomChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DefaultAppImage(size: 100.h),
                SizedBox(height: 19.h),
                Text(
                  'Dr Bellamy',
                  textAlign: TextAlign.center,
                  style: AppText.bold700(context).copyWith(
                    fontSize: 18.sp,
                    color: AppColors.textBrown,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Psychiatry • Psychiatry',
                  textAlign: TextAlign.center,
                  style: AppText.bold400(context).copyWith(
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomStarRating(),
                    SizedBox(width: 8.w),
                    Text(
                      '976 Reviews',
                      style: AppText.bold500(context).copyWith(
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 48.h),
                SizedBox(
                  width: 264.w,
                  child: Text(
                    'You will get instant service from Dr Bellamy',
                    textAlign: TextAlign.center,
                    style: AppText.bold400(context).copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Service charge:',
                      style: AppText.bold400(context).copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    const AmountPerHourView(),
                  ],
                ),
                SizedBox(height: 72.h),
                AppButton(
                  label: 'Book Now',
                  onTap: () {
                    AppNavigator.to(context, const SessionBookingScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AmountPerHourView extends StatelessWidget {
  const AmountPerHourView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '${AppConstants.nairaSymbol}5000',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18.sp,
          color: AppColors.lightText,
        ),
        children: <TextSpan>[
          TextSpan(
            text: '/hour',
            style: AppText.bold400(context).copyWith(
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class SessionBookingScreen extends StatelessWidget {
  const SessionBookingScreen({Key? key}) : super(key: key);

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
              const Expanded(
                child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    BookingScheduleView(),
                    BookingConfirmationView(),
                    BookingPaymentView(),
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
