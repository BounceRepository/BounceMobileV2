import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RoomItemTile extends StatelessWidget {
  const RoomItemTile({Key? key}) : super(key: key);

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
              Container(
                height: 35.h,
                width: 35.h,
                decoration: const BoxDecoration(
                  color: AppColors.textBrown,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 17.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Coal Dingo',
                          style: AppText.bold600(context).copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          ' • 1 hr ago',
                          style: AppText.bold400(context).copyWith(
                            fontSize: 12.sp,
                            color: const Color(0xff707070),
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
                          value: 2,
                          onTap: () {},
                        ),
                        const Spacer(),
                        _ActionButton(
                          icon: ChatRoomIcons.share,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 17.95.h),
          Container(
            height: 1.h,
            color: const Color(0xffD9D8D8).withOpacity(.3),
          ),
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
