import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/widgets/input/custom_textfield.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_divider.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/default_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final _borderRadius = BorderRadius.only(
  topLeft: Radius.circular(40.r),
  topRight: Radius.circular(40.r),
);

final _decoration = BoxDecoration(
  color: Colors.white,
  boxShadow: AppColors.boxshadow4,
  borderRadius: _borderRadius,
);

Future<dynamic> showCommentListBottomsheet(BuildContext context) {
  return showCustomBottomSheet(
    context,
    body: const CommentListBottomsheet(),
  );
}

class CommentListBottomsheet extends StatelessWidget {
  const CommentListBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: CustomBottomSheetBody(
        height: 608.h,
        padding: EdgeInsets.zero,
        borderRadius: _borderRadius,
        body: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 20.h, bottom: 12.h),
            decoration: _decoration,
            child: Text(
              'Comments',
              textAlign: TextAlign.center,
              style: AppText.bold700(context).copyWith(
                fontSize: 20.sp,
              ),
            ),
          ),
          const _CommentsListView(),
          const _MessageInputSection(),
        ],
      ),
    );
  }
}

class _CommentsListView extends StatelessWidget {
  const _CommentsListView();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          left: AppPadding.horizontal,
          right: AppPadding.horizontal,
        ),
        itemCount: 30,
        itemBuilder: (context, index) {
          return const _CommentListItem();
        },
      ),
    );
  }
}

class _CommentListItem extends StatelessWidget {
  const _CommentListItem();

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
                          'Jane Doe',
                          style: AppText.bold600(context).copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          '12h ago',
                          style: AppText.bold400(context).copyWith(
                            fontSize: 12.sp,
                            color: AppColors.grey3,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      lorem(paragraphs: 1, words: 10),
                      style: AppText.bold400(context).copyWith(
                        fontSize: 13.sp,
                      ),
                    ),
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
                    Row(
                      children: [
                        Text(
                          'View 5 more replies',
                          style: AppText.bold400(context).copyWith(
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        const Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
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

class _MessageInputSection extends StatefulWidget {
  const _MessageInputSection();

  @override
  State<_MessageInputSection> createState() => _MessageInputSectionState();
}

class _MessageInputSectionState extends State<_MessageInputSection> {
  late final TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: _decoration.copyWith(
        borderRadius: BorderRadius.zero,
      ),
      child: Row(
        children: [
          Padding(
            padding: AppPadding.symetricHorizontalOnly,
            child: DefaultAppImage(size: 48.h),
          ),
          Expanded(
            child: CustomTextField(
              controller: textController,
              hintText: 'Type message',
              suffixIcon: TextFieldIcon(
                icon: Icons.send,
                color: AppColors.lightText,
                onTap: () {
                  textController.clear();
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
