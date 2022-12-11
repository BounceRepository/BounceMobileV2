import 'package:bounce_patient_app/src/modules/feed/controllers/controllers.dart';
import 'package:bounce_patient_app/src/modules/feed/models/comment.dart';
import 'package:bounce_patient_app/src/modules/feed/models/feed.dart';
import 'package:bounce_patient_app/src/modules/feed/screens/reply_list_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/extensions/string.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/messenger.dart';
import 'package:bounce_patient_app/src/shared/widgets/input/custom_textfield.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_divider.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/default_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

final _borderRadius = BorderRadius.only(
  topLeft: Radius.circular(10.r),
  topRight: Radius.circular(10.r),
);

final _decoration = BoxDecoration(
  color: Colors.white,
  boxShadow: AppColors.boxshadow4,
  borderRadius: _borderRadius,
);

class CommentBottomsheetTitle extends StatelessWidget {
  const CommentBottomsheetTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 15.h, bottom: 8.h, left: AppPadding.horizontal),
      decoration: _decoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.toTitleCase,
            textAlign: TextAlign.center,
            style: AppText.bold700(context).copyWith(
              fontSize: 20.sp,
            ),
          ),
          const CloseButton(),
        ],
      ),
    );
  }
}

class CommentListView<T extends CommentController> extends StatelessWidget {
  const CommentListView({
    super.key,
    required this.isReplies,
    required this.comments,
    required this.feed,
  });

  final bool isReplies;
  final Feed feed;
  final List<Comment> comments;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
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
            feed: feed,
          );
        },
      ),
    );
  }
}

class CommentListItem<T extends CommentController> extends StatefulWidget {
  const CommentListItem({
    super.key,
    required this.hasReplies,
    required this.feed,
    required this.comment,
    this.showDivider = true,
  });

  final bool hasReplies;
  final Feed feed;
  final Comment comment;
  final bool showDivider;

  @override
  State<CommentListItem<T>> createState() => _CommentListItemState<T>();
}

class _CommentListItemState<T extends CommentController>
    extends State<CommentListItem<T>> {
  late final TextEditingController replyController;

  @override
  void initState() {
    super.initState();
    replyController = TextEditingController();
  }

  @override
  void dispose() {
    replyController.dispose();
    super.dispose();
  }

  void createReply() async {
    if (replyController.text.isEmpty) {
      return;
    }

    final controller = context.read<T>();
    final comment = replyController.text;
    replyController.clear();
    FocusScope.of(context).unfocus();
    try {
      await controller.createReply(
        comment: comment,
        commentId: widget.comment.id,
      );
      getCommentList();
    } on Failure {
      Messenger.error(message: 'Failed to send comment');
    }
  }

  void getCommentList() async {
    final controller = context.read<T>();

    try {
      await controller.getCommentList(widget.feed.id);
    } on Failure {
      Messenger.error(message: 'Failed to comments');
    }
  }

  @override
  Widget build(BuildContext context) {
    final author = widget.comment.author;

    return Padding(
      padding: EdgeInsets.only(top: 28.h),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              author.profilePicture != null
                  ? CustomCacheNetworkImage(image: author.profilePicture!, size: 35.h)
                  : DefaultAppImage(size: 35.h),
              SizedBox(width: 17.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.comment.author.name.toTitleCase,
                          style: AppText.bold600(context).copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          widget.comment.formattedTime,
                          style: AppText.bold400(context).copyWith(
                            fontSize: 12.sp,
                            color: AppColors.grey3,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    ReadMoreText(
                      widget.comment.message,
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
                    widget.hasReplies
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15.h),
                              CustomTextField(
                                controller: replyController,
                                hintText: 'Reply',
                              ),
                              SizedBox(height: 8.h),
                              widget.comment.replyCount != 0
                                  ? GestureDetector(
                                      onTap: () {
                                        showReplyListBottomsheet<T>(
                                            context: context,
                                            comment: widget.comment,
                                            feed: widget.feed);
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            'View ${widget.comment.replyCount} more replies',
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
          widget.showDivider
              ? Column(
                  children: [
                    SizedBox(height: 12.h),
                    const CustomDivider(),
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
