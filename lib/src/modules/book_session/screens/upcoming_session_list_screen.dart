import 'package:bounce_patient_app/src/modules/book_session/screens/join_session_screen.dart';
import 'package:bounce_patient_app/src/modules/book_session/widgets/sessions_item_tile.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpComingSessionListScreen extends StatelessWidget {
  const UpComingSessionListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(label: 'New Session'),
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            const _UpcomingSessionCard(),
            SliverPadding(
              padding: EdgeInsets.only(
                top: 20.h,
                left: AppPadding.horizontal,
                bottom: 20.h,
              ),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'This Month',
                  style: AppText.bold500(context).copyWith(
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ];
        },
        body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: AppPadding.symetricHorizontalOnly,
          itemCount: 30,
          itemBuilder: (context, index) {
            return const SessionItemTile();
          },
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
      child: Padding(
        padding: AppPadding.symetricHorizontalOnly,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              'Today',
              style: AppText.bold500(context).copyWith(
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: 23.12.h,
                bottom: 23.12.h,
                left: 20.w,
              ),
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(.52),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upcoming Session',
                    style: AppText.bold700(context).copyWith(
                      fontSize: 16.sp,
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
          ],
        ),
      ),
    );
  }

  Widget bookNowButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.to(context, const JoinSessionScreen());
      },
      child: Text(
        'Join Now',
        style: AppText.bold700(context).copyWith(
          fontSize: 16.sp,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
