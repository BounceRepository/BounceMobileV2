import 'package:bounce_patient_app/src/modules/auth/widgets/auth_button.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> showSuccessBottomsheet(
  BuildContext context, {
  required String title,
  required String desc,
  required Function() onTap,
}) {
  return showCustomBottomSheet(
    context,
    isDismissible: false,
    enableDrag: false,
    body: _Body(
      title: title,
      desc: desc,
      onTap: onTap,
    ),
  );
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
    required this.title,
    required this.desc,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final String desc;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: CustomBottomSheetBody(
        content: [
          Container(
            height: 150.h,
            width: 150.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  const Color(0xffFF7C2B).withOpacity(.8),
                  const Color(0xffEADACF),
                ],
              ),
            ),
            child: Icon(
              Icons.thumb_up_outlined,
              color: Colors.white,
              size: 80.sp,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            title,
            style: AppText.bold600(context).copyWith(
              fontSize: 20.sp,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: AppText.bold400(context).copyWith(
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 37.h),
          AuthButton(
            label: 'Return to Login',
            onTap: onTap,
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
