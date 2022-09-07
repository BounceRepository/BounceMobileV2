import 'package:bounce_patient_app/src/modules/appointment/widgets/sessions_item_tile.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/sliver_appbar_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        //AppNavigator.removeAllUntil(context, const DashboardView());
        return Future.value(true);
      },
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SliverToBoxAdapter(child: CustomAppBar()),
              const _UpcomingSessionCard(),
              const _SessionsFilterSection(),
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.h,
                  horizontal: AppPadding.horizontal,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => const SessionItemTile(),
                    childCount: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UpcomingSessionCard extends StatelessWidget {
  const _UpcomingSessionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(
          top: 13.h,
          right: AppPadding.horizontal,
          left: AppPadding.horizontal,
        ),
        padding: EdgeInsets.only(
          top: 23.12.h,
          bottom: 23.12.h,
          left: 20.w,
        ),
        decoration: BoxDecoration(
          color: const Color(0xffFEF3E7),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upcoming Session',
              style: AppText.bold800(context).copyWith(
                fontSize: 22.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Sahana V, Msc in Clinical Psychology',
              style: AppText.bold400(context).copyWith(
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              '7:30 PM - 8:30 PM',
              style: AppText.bold600(context).copyWith(
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 11.18.h),
            bookNowButton(context),
          ],
        ),
      ),
    );
  }

  Widget bookNowButton(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Text(
            'Join Now',
            style: AppText.bold700(context).copyWith(
              fontSize: 16.sp,
              color: AppColors.primary,
            ),
          ),
          SizedBox(width: 6.13.w),
          Icon(
            Icons.play_circle,
            size: 20.sp,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}

class _SessionsFilterSection extends StatelessWidget {
  const _SessionsFilterSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        maxHeight: 65.h,
        minHeight: 65.h,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(
            top: 28.h,
            left: AppPadding.horizontal,
            right: AppPadding.horizontal,
            bottom: 10.h,
          ),
          child: Row(
            children: [
              Text(
                'All Sessions',
                style: AppText.bold500(context).copyWith(
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(width: 7.34.w),
              Icon(
                Icons.keyboard_arrow_down,
                size: 20.sp,
              ),
              const Spacer(),
              SvgPicture.asset(
                AppIcons.sort,
                width: 12.w,
                height: 16.5.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
