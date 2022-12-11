import 'package:bounce_patient_app/src/modules/feed/controllers/controllers.dart';
import 'package:bounce_patient_app/src/modules/feed/models/feed.dart';
import 'package:bounce_patient_app/src/modules/feed/widgets/comment_list_bottomsheet_view.dart';
import 'package:bounce_patient_app/src/modules/feed/widgets/feed_item_tile.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/messenger.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/widgets/input/custom_textfield.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_loading_indicator.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/empty_view.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

Future<dynamic> showCommentListBottomsheet<T extends CommentController>({
  required BuildContext context,
  required Feed feed,
}) {
  return showCustomBottomSheet(
    context,
    body: _Body<T>(feed),
  );
}

class _Body<T extends CommentController> extends StatefulWidget {
  const _Body(this.feed);

  final Feed feed;

  @override
  State<_Body<T>> createState() => _BodyState<T>();
}

class _BodyState<T extends CommentController> extends State<_Body<T>> {
  late final TextEditingController commentController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    commentController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  void init() async {
    final controller = context.read<T>();

    try {
      setState(() => isLoading = true);
      await getCommentList();
      setState(() => isLoading = false);
    } on Failure catch (e) {
      setState(() => isLoading = false);
      controller.setFailure(e);
    }
  }

  Future<void> getCommentList() async {
    final controller = context.read<T>();

    try {
      await controller.getCommentList(widget.feed.id);
    } on Failure {
      rethrow;
    }
  }

  void createComment() async {
    if (commentController.text.isEmpty) {
      return;
    }

    final controller = context.read<T>();
    final comment = commentController.text;
    commentController.clear();
    FocusScope.of(context).unfocus();
    try {
      await controller.createComment(
        comment: comment,
        feedId: widget.feed.id,
      );
      await getCommentList();
    } on Failure {
      Messenger.error(message: 'Failed to send comment');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Consumer<T>(
        builder: (context, controller, _) {
          return CustomBottomSheetBody(
            height: 700.h,
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
            body: [
              const CommentBottomsheetTitle(title: 'Comments'),
              if (T == TrendingCommentController)
                FeedItemTile<TrendingFeedController>(widget.feed, showComment: false),
              SizedBox(height: 10.h),
              Padding(
                padding: AppPadding.symetricHorizontalOnly,
                child: CustomTextField(
                  controller: commentController,
                  hintText: 'Add a comment',
                  onChanged: (value) {
                    setState(() {});
                  },
                  suffixIcon: commentController.text.isNotEmpty
                      ? TextFieldIcon(
                          icon: Icons.send,
                          color: AppColors.lightText,
                          onTap: createComment,
                        )
                      : null,
                ),
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: SizedBox(
                  height: 458.h,
                  child: Column(
                    children: isLoading
                        ? [
                            SizedBox(height: 200.h),
                            const CustomLoadingIndicator(),
                            Text(
                              'Loading comments...',
                              style: AppText.bold400(context),
                            ),
                          ]
                        : controller.failure != null
                            ? [ErrorScreen(error: controller.failure!, retry: init)]
                            : controller.comments.isEmpty
                                ? [
                                    SizedBox(height: 150.h),
                                    const EmptyListView(text: 'No comment'),
                                  ]
                                : [
                                    CommentListView<T>(
                                      isReplies: true,
                                      comments: controller.comments,
                                      feed: widget.feed,
                                    ),
                                  ],
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
