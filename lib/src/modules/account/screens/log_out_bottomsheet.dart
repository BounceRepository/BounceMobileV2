import 'package:bounce_patient_app/src/modules/auth/screens/sign_in_screen.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> showLogoutBottomsheet({
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
        const BottomSheetTitle('Are you sure you want to logout?'),
        SizedBox(height: 40.h),
        Row(
          children: [
            Expanded(
              child: AppButton(
                label: 'Yes',
                backgroundColor: AppColors.error,
                onTap: () {
                  AppNavigator.removeAllUntil(context, const SignInScreen());
                },
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: AppButton(
                label: 'No',
                labelColor: AppColors.lightText,
                backgroundColor: Colors.transparent,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 40.h),
      ],
    );
  }
}
