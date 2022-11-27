import 'package:bounce_patient_app/src/modules/feed/widgets/comment_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_divider.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/default_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RoomChatItem extends StatelessWidget {
  const RoomChatItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              DefaultAppImage(size: 35.h),
              SizedBox(width: 20.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Coal Dingo',
                          style: AppText.bold600(context).copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          'Just now',
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
                    SizedBox(height: 17.95.h),
                    Row(
                      children: [
                        _ActionButton(
                          icon: ChatRoomIcons.like,
                          value: 12,
                          onTap: () {},
                        ),
                        SizedBox(width: 29.7.w),
                        _ActionButton(
                          icon: ChatRoomIcons.comment,
                          onTap: () => showCommentListBottomsheet(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 17.95.h),
          const CustomDivider(),
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
    this.value,
  }) : super(key: key);

  final String icon;
  final int? value;
  final Function() onTap;

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
