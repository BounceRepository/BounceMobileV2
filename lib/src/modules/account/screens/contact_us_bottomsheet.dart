import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<dynamic> showContactUsBottomsheet({
  required BuildContext context,
}) {
  return showCustomBottomSheet(
    context,
    body: const _Body(),
  );
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetBody(
      body: [
        const BottomSheetTitle('Contact Us'),
        SizedBox(height: 40.h),
        _Tile(
          icon: AppIcons.call,
          title: '+234 817 545 1000',
          onTap: () {},
        ),
        _Tile(
          icon: AppIcons.mail,
          title: 'bounce@gmail.com',
          onTap: () {},
        ),
        SizedBox(height: 40.h),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final String icon;
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: 24.h),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(15.sp),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: AppColors.boxshadow4,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                icon,
                height: 20.h,
                width: 20.h,
                fit: BoxFit.cover,
                color: AppColors.primary,
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                style: AppText.titleStyle(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}