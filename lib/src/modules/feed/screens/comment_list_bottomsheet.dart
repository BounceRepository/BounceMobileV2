import 'package:bounce_patient_app/src/modules/feed/controllers/controllers.dart';
import 'package:bounce_patient_app/src/modules/feed/models/feed.dart';
import 'package:bounce_patient_app/src/modules/feed/widgets/comment_list_bottomsheet_view.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:flutter/material.dart';
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
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCommentList();
    });
  }

  void getCommentList() async {
    final controller = context.read<T>();

    try {
      setState(() => isLoading = true);
      await controller.getCommentList(widget.feed.id);
      setState(() => isLoading = false);
    } on Failure catch (e) {
      setState(() => isLoading = false);
      controller.setFailure(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (context, controller, _) {
        return CommentListBottomsheetView<T>(
          title: 'Comments',
          failure: controller.failure,
          comments: controller.comments,
          isLoading: isLoading,
          onRetry: getCommentList,
        );
      },
    );
  }
}
