import 'package:bounce_patient_app/src/local/local_storage_service.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/sign_in_screen.dart';
import 'package:bounce_patient_app/src/modules/book_session/controllers/session_list_controller.dart';
import 'package:bounce_patient_app/src/modules/chat/controllers/chat_controller.dart';
import 'package:bounce_patient_app/src/modules/feed/controllers/feed_controller.dart';
import 'package:bounce_patient_app/src/modules/journal/controllers/journal_list_controller.dart';
import 'package:bounce_patient_app/src/modules/notifications/controllers/notification_controller.dart';
import 'package:bounce_patient_app/src/modules/playlist/controllers/song_list_controller.dart';
import 'package:bounce_patient_app/src/modules/wallet/controllers/transaction_list_controller.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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

  void logOut(BuildContext context) {
    context.read<NotificationController>().clear();
    context.read<JournalController>().clear();
    context.read<MyFeedController>().clear();
    context.read<ChatController>().clear();
    context.read<SessionListController>().clear();
    context.read<TransactionListController>().clear();
    context.read<SongListController>().clear();
    LocalStorageService.clear();
    AppNavigator.removeAllUntil(context, const SignInScreen());
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetBody(
      body: [
        const BottomSheetDragger(),
        SizedBox(height: 20.h),
        Text(
          'Are you sure you want to logout?',
          style: AppText.bold300(context).copyWith(
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 20.h),
        Row(
          children: [
            Expanded(
              child: AppButton(
                label: 'Yes',
                backgroundColor: AppColors.error,
                onTap: () => logOut(context),
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
