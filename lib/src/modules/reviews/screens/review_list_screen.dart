import 'package:bounce_patient_app/src/modules/reviews/widgets/review_list_item.dart';
import 'package:bounce_patient_app/src/modules/reviews/widgets/star_rating_info_view.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_star_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewListScreen extends StatelessWidget {
  const ReviewListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        label: 'Reviews',
        backgroundColor: Color(0xffFEF3E7),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const _RatingInformationSection(),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 20.h,
              horizontal: AppPadding.horizontal,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => const ReviewListItem(),
                childCount: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingInformationSection extends StatelessWidget {
  const _RatingInformationSection();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverToBoxAdapter(
      child: Container(
        height: 372.h,
        width: size.width,
        padding: EdgeInsets.only(bottom: 38.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.r),
            bottomRight: Radius.circular(40.r),
          ),
          gradient: const LinearGradient(
            colors: [
              Color(0xffFEF3E7),
              Color(0xffFCFAFA),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RichText(
              text: TextSpan(
                text: '4.5',
                style: AppText.bold800(context).copyWith(
                  fontSize: 20.sp,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '/5',
                    style: AppText.bold400(context).copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 13.08.h),
            CustomStarRating(rating: 4, size: 14.5.sp),
            SizedBox(height: 12.86.h),
            Text(
              '20 Ratings',
              style: AppText.bold500(context).copyWith(
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 26.h),
            const StarRatingInfoView(),
          ],
        ),
      ),
    );
  }
}
