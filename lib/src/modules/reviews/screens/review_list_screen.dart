import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/reviews/controllers/review_controller.dart';
import 'package:bounce_patient_app/src/modules/reviews/models/review.dart';
import 'package:bounce_patient_app/src/modules/reviews/widgets/review_list_item.dart';
import 'package:bounce_patient_app/src/modules/reviews/widgets/star_rating_info_view.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_loading_indicator.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_star_rating.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/empty_view.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ReviewListScreen extends StatefulWidget {
  const ReviewListScreen({super.key, required this.therapist});

  final Therapist therapist;

  @override
  State<ReviewListScreen> createState() => _ReviewListScreenState();
}

class _ReviewListScreenState extends State<ReviewListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getReviews();
    });
  }

  void getReviews() async {
    final controller = context.read<ReviewController>();

    try {
      await controller.getAllReviewForTherapist(widget.therapist.id);
    } on Failure catch (e) {
      controller.setFailure(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        label: 'Reviews',
        backgroundColor: Color(0xffFEF3E7),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Consumer<ReviewController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return const CustomLoadingIndicator();
          }

          final error = controller.failure;
          if (error != null) {
            return ErrorScreen(error: error, retry: getReviews);
          }

          final reviewInfo = controller.reviewInfo;
          if (reviewInfo == null) {
            return const SizedBox.shrink();
          }

          if (controller.reviews.isEmpty) {
            return const EmptyListView(text: 'No reviews');
          }

          final reviews = controller.reviews;
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _RatingInformationSection(reviewInfo: reviewInfo),
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.h,
                  horizontal: AppPadding.horizontal,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => ReviewListItem(reviews[index]),
                    childCount: reviews.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _RatingInformationSection extends StatelessWidget {
  const _RatingInformationSection({required this.reviewInfo});

  final ReviewInfo reviewInfo;

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
                text: reviewInfo.avgReviewRating.toString(),
                style: AppText.bold800(context).copyWith(
                  fontSize: 20.sp,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '/5',
                    style: AppText.bold400(context).copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 13.08.h),
            CustomStarRating(rating: reviewInfo.avgReviewRating, size: 14.5.sp),
            SizedBox(height: 12.86.h),
            Text(
              '${reviewInfo.totalReviewCount} Ratings',
              style: AppText.bold500(context).copyWith(
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 26.h),
            StarRatingInfoView(reviewInfo: reviewInfo),
          ],
        ),
      ),
    );
  }
}
