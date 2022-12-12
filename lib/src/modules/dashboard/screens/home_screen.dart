import 'dart:developer';

import 'package:bounce_patient_app/src/modules/book_session/screens/upcoming_session_list_screen.dart';
import 'package:bounce_patient_app/src/modules/book_session/screens/therapist_list_screen.dart';
import 'package:bounce_patient_app/src/modules/dashboard/screens/dashboard_view.dart';
import 'package:bounce_patient_app/src/modules/dashboard/screens/mood_icons_view.dart';
import 'package:bounce_patient_app/src/modules/notifications/controllers/notification_controller.dart';
import 'package:bounce_patient_app/src/modules/notifications/screens/notification_list_screen.dart';
import 'package:bounce_patient_app/src/modules/notifications/widgets/notification_bell.dart';
import 'package:bounce_patient_app/src/modules/playlist/screens/discover_screen.dart';
import 'package:bounce_patient_app/src/modules/care_plan/screens/care_plans_screen.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/assets/images.dart';
import 'package:bounce_patient_app/src/shared/extensions/string.dart';
import 'package:bounce_patient_app/src/shared/models/app_session.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/default_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    updateNotificationToken();
  }

  void updateNotificationToken() async {
    try {
      await context.read<NotificationController>().updateToken();
    } on Failure catch (e) {
      log(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: AppColors.lightVersion,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: AppPadding.vertical),
                  children: [
                    const _ProfileHeaderSection(),
                    SizedBox(height: 26.h),
                    const MoodIconsView(),
                    const _SessionsCard(),
                    SizedBox(height: 26.h),
                    const _ChatRoomSection(),
                    SizedBox(height: 26.h),
                    const _QuoteCard(),
                    const _PlanExpiredCard(),
                    SizedBox(height: 26.h),
                    therapistCard(context),
                    SizedBox(height: 26.h),
                    //const _ArticlesSection(),
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

class _ProfileHeaderSection extends StatelessWidget {
  const _ProfileHeaderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = AppSession.user;

    if (user == null) {
      return const SizedBox.shrink();
    }

    final image = user.profilePicture;
    return Padding(
      padding: AppPadding.symetricHorizontalOnly,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          image == null ? const DefaultAppImage() : CustomCacheNetworkImage(image: image),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
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
            child: Consumer<NotificationController>(builder: (context, controller, _) {
              return NotificationBell(
                count: controller.unReadNotificationCount,
              );
            }),
          ),
        ],
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
        AppNavigator.to(context, const UpComingSessionListScreen());
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
      padding: AppPadding.symetricHorizontalOnly,
      child: Row(
        children: [
          button(
            context,
            icon: AppImages.discover,
            label: 'Discover',
            onTap: () {
              AppNavigator.to(context, const DiscoverScreen());
            },
          ),
          SizedBox(width: 15.w),
          button(
            context,
            icon: AppImages.rantRoom,
            label: 'Chat',
            onTap: () {
              AppNavigator.to(context, const DashboardView(selectedIndex: 3));
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
              style: AppText.bold300(context).copyWith(
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

class _PlanExpiredCard extends StatelessWidget {
  const _PlanExpiredCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 26.h,
        right: AppPadding.horizontal,
        left: AppPadding.horizontal,
      ),
      padding: EdgeInsets.only(
        top: 17.6.h,
        left: 16.w,
        bottom: 17.6.h,
        right: 16.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColors.primary,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Plan Expired',
                  style: AppText.bold700(context).copyWith(
                    fontSize: 18.sp,
                    color: AppColors.lightVersion,
                  ),
                ),
                Text(
                  'Get back chat access and meditation sessions',
                  style: AppText.bold300(context).copyWith(
                    fontSize: 14.sp,
                    color: AppColors.lightVersion,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    AppNavigator.to(context, const CarePlansScreen());
                  },
                  child: Row(
                    children: [
                      Text(
                        'Buy More',
                        style: AppText.bold700(context).copyWith(
                          fontSize: 16.sp,
                          color: AppColors.lightVersion,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      const Icon(
                        Icons.arrow_forward,
                        color: AppColors.lightVersion,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 36.w),
          SvgPicture.asset(
            AppIcons.meditation,
            width: 84.w,
            height: 64.h,
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
          height: 265.h,
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
        boxShadow: AppColors.boxshadow4,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        children: [
          Container(
            height: 140.h,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lorem(paragraphs: 1, words: 5),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.bold600(context).copyWith(
                    fontSize: 14.sp,
                    color: AppColors.textBrown,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  lorem(paragraphs: 1, words: 15),
                  maxLines: 3,
                  style: AppText.bold500(context).copyWith(
                    fontSize: 8.sp,
                    color: AppColors.textBrown,
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
