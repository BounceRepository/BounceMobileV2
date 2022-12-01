import 'package:bounce_patient_app/src/modules/feed/controllers/controllers.dart';
import 'package:bounce_patient_app/src/modules/feed/models/comment.dart';
import 'package:bounce_patient_app/src/modules/feed/screens/reply_list_bottomsheet.dart';
import 'package:bounce_patient_app/src/modules/feed/widgets/message_input_view.dart';
import 'package:bounce_patient_app/src/shared/extensions/string.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_divider.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_loading_indicator.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/default_app_image.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/empty_view.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

final _borderRadius = BorderRadius.only(
  topLeft: Radius.circular(40.r),
  topRight: Radius.circular(40.r),
);

final _decoration = BoxDecoration(
  color: Colors.white,
  boxShadow: AppColors.boxshadow4,
  borderRadius: _borderRadius,
);

class CommentListBottomsheetView<T extends CommentController> extends StatelessWidget {
  const CommentListBottomsheetView({
    super.key,
    required this.title,
    this.hasReplies = true,
    required this.comments,
    required this.failure,
    required this.isLoading,
    required this.onRetry,
  });

  final String title;
  final bool hasReplies;
  final List<Comment> comments;
  final Failure? failure;
  final bool isLoading;
  final Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: CustomBottomSheetBody(
        height: 608.h,
        padding: EdgeInsets.zero,
        borderRadius: _borderRadius,
        body: isLoading
            ? [
                SizedBox(height: 200.h),
                const CustomLoadingIndicator(),
                Text(
                  'Loading comments...',
                  style: AppText.bold400(context),
                ),
              ]
            : failure != null
                ? [ErrorScreen(error: failure!, retry: onRetry)]
                : comments.isEmpty
                    ? [
                        SizedBox(height: 150.h),
                        const EmptyListView(),
                      ]
                    : [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(top: 15.h, bottom: 8.h),
                          decoration: _decoration,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const BackButton(),
                              Text(
                                title.toTitleCase,
                                textAlign: TextAlign.center,
                                style: AppText.bold700(context).copyWith(
                                  fontSize: 20.sp,
                                ),
                              ),
                              const BackButton(color: Colors.transparent),
                            ],
                          ),
                        ),
                        _CommentsListView<T>(
                          isReplies: hasReplies,
                          comments: comments,
                        ),
                        const FeedMessageInputView(),
                      ],
      ),
    );
  }
}

class _CommentsListView<T extends CommentController> extends StatelessWidget {
  const _CommentsListView({required this.isReplies, required this.comments});

  final bool isReplies;
  final List<Comment> comments;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          left: AppPadding.horizontal,
          right: AppPadding.horizontal,
        ),
        itemCount: comments.length,
        itemBuilder: (context, index) {
          final comment = comments[index];
          return CommentListItem<T>(
            hasReplies: isReplies,
            comment: comment,
          );
        },
      ),
    );
  }
}

class CommentListItem<T extends CommentController> extends StatelessWidget {
  const CommentListItem({super.key, required this.hasReplies, required this.comment});

  final bool hasReplies;
  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 28.h),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultAppImage(size: 35.h),
              SizedBox(width: 17.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          comment.author.userName,
                          style: AppText.bold600(context).copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          comment.formattedTime,
                          style: AppText.bold400(context).copyWith(
                            fontSize: 12.sp,
                            color: AppColors.grey3,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    ReadMoreText(
                      comment.message,
                      trimLines: 3,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: 'Show less',
                      style: AppText.bold400(context).copyWith(
                        fontSize: 13.sp,
                      ),
                      moreStyle: AppText.bold400(context).copyWith(
                        fontSize: 13.sp,
                        color: AppColors.primary,
                      ),
                      lessStyle: AppText.bold400(context).copyWith(
                        fontSize: 13.sp,
                        color: AppColors.primary,
                      ),
                    ),
                    hasReplies
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8.h),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'Reply',
                                  style: AppText.bold400(context).copyWith(
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              comment.replyCount != 0
                                  ? GestureDetector(
                                      onTap: () {
                                        showReplyListBottomsheet<T>(
                                          context: context,
                                          comment: comment,
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            'View ${comment.replyCount} more replies',
                                            style: AppText.bold400(context).copyWith(
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                          SizedBox(width: 5.w),
                                          const Icon(Icons.keyboard_arrow_down),
                                        ],
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          const CustomDivider(),
        ],
      ),
    );
  }
}
