import 'package:bounce_patient_app/src/modules/feed/controllers/controllers.dart';
import 'package:bounce_patient_app/src/modules/feed/models/feed.dart';
import 'package:bounce_patient_app/src/modules/feed/screens/comment_list_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/extensions/string.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/messenger.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_divider.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/default_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class FeedItemTile<T extends FeedController> extends StatefulWidget {
  const FeedItemTile(this.feed, {Key? key, this.showComment = true}) : super(key: key);

  final Feed feed;
  final bool showComment;

  @override
  State<FeedItemTile<T>> createState() => _FeedItemTileState<T>();
}

class _FeedItemTileState<T extends FeedController> extends State<FeedItemTile<T>> {
  void likeFeed(BuildContext context) async {
    try {
      await context.read<T>().likeFeed(widget.feed.id);
      setState(() {});
    } on Failure {
      Messenger.error(message: 'Failed to like');
    }
  }

  @override
  Widget build(BuildContext context) {
    final author = widget.feed.author;

    return Padding(
      padding: EdgeInsets.only(
        left: AppPadding.horizontal,
        right: AppPadding.horizontal,
        top: 16.h,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              author.profilePicture != null
                  ? CustomCacheNetworkImage(image: author.profilePicture!, size: 35.h)
                  : DefaultAppImage(size: 35.h),
              SizedBox(width: 20.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.feed.author.name.toTitleCase,
                          style: AppText.bold600(context).copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          widget.feed.formattedTime,
                          style: AppText.bold400(context).copyWith(
                            fontSize: 12.sp,
                            color: AppColors.grey3,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    ReadMoreText(
                      widget.feed.message,
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
                    SizedBox(height: 17.95.h),
                    Row(
                      children: [
                        _ActionButton(
                          icon: ChatRoomIcons.like,
                          color: widget.feed.isLikedByMe ? AppColors.primary : null,
                          value: widget.feed.likesCount,
                          onTap: () => likeFeed(context),
                        ),
                        SizedBox(width: 29.7.w),
                        widget.showComment
                            ? _ActionButton(
                                icon: ChatRoomIcons.comment,
                                value: widget.feed.commentCount,
                                onTap: () {
                                  if (T == TrendingFeedController) {
                                    showCommentListBottomsheet<TrendingCommentController>(
                                        context: context, feed: widget.feed);
                                    return;
                                  }
                                },
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          widget.showComment
              ? Column(
                  children: [SizedBox(height: 17.95.h), const CustomDivider()],
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.color,
    this.value,
  }) : super(key: key);

  final String icon;
  final int? value;
  final Function() onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (value == null) {
      return GestureDetector(
        onTap: onTap,
        child: SvgPicture.asset(
          icon,
          height: 20.h,
          width: 20.h,
          fit: BoxFit.cover,
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            height: 20.h,
            width: 20.h,
            fit: BoxFit.cover,
            color: color,
          ),
          SizedBox(width: 8.85.w),
          Text(
            value!.toString(),
            style: AppText.bold400(context).copyWith(
              fontSize: 13.33.sp,
            ),
          ),
        ],
      ),
    );
  }
}
