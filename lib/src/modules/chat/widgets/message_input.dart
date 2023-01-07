import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({
    super.key,
    required this.textEditingController,
    this.pickImage,
    required this.send,
    this.textStyle,
    this.sendButtonColor,
  });

  final TextEditingController textEditingController;
  final Function()? pickImage;
  final Function() send;
  final TextStyle? textStyle;
  final Color? sendButtonColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: AppPadding.horizontal,
        right: AppPadding.horizontal,
        bottom: 20.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffFCE7D8).withOpacity(.32),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          pickImage != null
              ? _button(
                  icon: AppIcons.camera,
                  onTap: pickImage!,
                )
              : const SizedBox.shrink(),
          Flexible(
            child: TextField(
              minLines: 1,
              maxLines: 5,
              style: textStyle ??
                  AppText.bold300(context).copyWith(
                    fontSize: 14.sp,
                  ),
              controller: textEditingController,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: "Type a message",
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 15.w),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(18.r),
                ),
              ),
            ),
          ),
          _button(
            icon: AppIcons.send,
            onTap: send,
            color: sendButtonColor,
          ),
        ],
      ),
    );
  }

  Widget _button({
    required String icon,
    required Function() onTap,
    Color? color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100.r),
      child: Padding(
        padding: EdgeInsets.all(12.sp),
        child: SvgPicture.asset(
          icon,
          height: 24.h,
          width: 24.h,
          fit: BoxFit.cover,
          color: color,
        ),
      ),
    );
  }
}
