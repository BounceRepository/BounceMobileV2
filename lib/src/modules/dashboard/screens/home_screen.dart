import 'package:bounce_patient_app/src/modules/appointment/screens/sessions_screen.dart';
import 'package:bounce_patient_app/src/modules/appointment/screens/therapist_list_screen.dart';
import 'package:bounce_patient_app/src/modules/dashboard/screens/mood_icons_view.dart';
import 'package:bounce_patient_app/src/modules/notifications/screens/notification_list_screen.dart';
import 'package:bounce_patient_app/src/modules/notifications/widgets/notification_bell.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/assets/images.dart';
import 'package:bounce_patient_app/src/shared/extensions/string.dart';
import 'package:bounce_patient_app/src/shared/models/datastore.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/default_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = AppSession.user;

    if (user == null) {
      return const SizedBox.shrink();
    }

    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return Future.value(true);
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: AppPadding.vertical),
                  children: [
                    Padding(
                      padding: AppPadding.symetricHorizontalOnly,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppImageView(
                            AppImages.image,
                            size: 68.h,
                          ),
                          SizedBox(width: 8.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Good Afternoon,',
                                style: AppText.bold400(context).copyWith(
                                  fontSize: 18.sp,
                                ),
                              ),
                              Text(
                                user.userName.toTitleCase,
                                style: AppText.bold700(context).copyWith(
                                  fontSize: 18.sp,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              AppNavigator.to(
                                context,
                                const NotificationListScreen(),
                              );
                            },
                            child: const NotificationBell(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 26.h),
                    const MoodIconsView(),
                    SizedBox(height: 26.h),
                    const _SessionsCard(),
                    SizedBox(height: 26.h),
                    const _ChatRoomSection(),
                    SizedBox(height: 16.h),
                    const _QuoteCard(),
                    SizedBox(height: 26.h),
                    therapistCard(context),
                    SizedBox(height: 26.h),
                    const _ArticlesSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget therapistCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.to(context, const TherapistListScreen());
      },
      child: Container(
        margin: AppPadding.symetricHorizontalOnly,
        padding: EdgeInsets.only(top: 21.h, bottom: 18.h, right: 50.w, left: 17.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: const Color(0xffFEF3E7),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              DashboardIcons.appointment,
              color: AppColors.textBrown,
              height: 28.h,
              width: 28.h,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Therapists',
                    style: AppText.bold600(context).copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    'An Overview to search for doctors and have mini therapy.',
                    style: AppText.bold400(context).copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SessionsCard extends StatelessWidget {
  const _SessionsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppPadding.symetricHorizontalOnly,
      padding: EdgeInsets.symmetric(vertical: 23.12.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 199.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1 on 1 Sessions',
                  style: AppText.bold800(context).copyWith(
                    fontSize: 22.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Let’s open up to the things that matter the most ',
                  style: AppText.bold400(context).copyWith(
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 11.18.h),
                bookNowButton(context),
              ],
            ),
          ),
          Image.asset(
            AppImages.meetup,
            width: 85.27.w,
            height: 80.h,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  Widget bookNowButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.to(context, const SessionsScreen());
      },
      child: Row(
        children: [
          Text(
            'Book Now',
            style: AppText.bold700(context).copyWith(
              fontSize: 16.sp,
              color: AppColors.primary,
            ),
          ),
          SizedBox(width: 6.13.w),
          Icon(
            Icons.calendar_month,
            size: 20.sp,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}

class _ChatRoomSection extends StatelessWidget {
  const _ChatRoomSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Row(
        children: [
          button(
            context,
            icon: AppImages.discover,
            label: 'Discover',
            onTap: () {},
          ),
          SizedBox(width: 15.w),
          button(
            context,
            icon: AppImages.rantRoom,
            label: 'Rant Room',
            onTap: () {
              // AppNavigator.to(context, DashboardView());
            },
          ),
        ],
      ),
    );
  }

  Widget button(
    BuildContext context, {
    required String icon,
    required String label,
    required Function() onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 62.h,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(16.r),
          ),
          padding: EdgeInsets.only(left: 18.44.w),
          child: Row(
            children: [
              Image.asset(
                icon,
                height: 22.h,
                width: 22.h,
                fit: BoxFit.cover,
                color: AppColors.primary,
              ),
              SizedBox(width: 12.w),
              Text(
                label,
                style: AppText.bold700(context).copyWith(
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuoteCard extends StatelessWidget {
  const _QuoteCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppPadding.symetricHorizontalOnly,
      padding: EdgeInsets.only(
        top: 21.h,
        bottom: 18.h,
        left: 15.w,
        right: 12.w,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffF8F6F6),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xffF4F4F4)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '“It is better to conquer yourself than to win a thousand battles”',
              style: AppText.bold700(context).copyWith(
                fontSize: 14.sp,
              ),
            ),
          ),
          SizedBox(width: 15.w),
          SvgPicture.asset(
            AppIcons.quote,
            width: 24.w,
            height: 20.h,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}

class _ArticlesSection extends StatelessWidget {
  const _ArticlesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppPadding.symetricHorizontalOnly,
          child: Text(
            'Articles',
            style: AppText.bold700(context).copyWith(
              fontSize: 18.sp,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 230.h,
          child: ListView.separated(
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            padding: AppPadding.symetricHorizontalOnly,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return articleItem(context);
            },
            separatorBuilder: (context, index) {
              return SizedBox(width: 20.w);
            },
          ),
        ),
      ],
    );
  }

  Widget articleItem(BuildContext context) {
    return Container(
      width: 178.w,
      margin: EdgeInsets.symmetric(vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: AppColors.boxshadow,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        children: [
          Container(
            height: 120.h,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '4 Habits Everyone Needs for Better Mental Health',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.bold600(context).copyWith(
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'For thousands of years, humans have recognized that mood changes are bad.',
                  style: AppText.bold500(context).copyWith(
                    fontSize: 8.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
