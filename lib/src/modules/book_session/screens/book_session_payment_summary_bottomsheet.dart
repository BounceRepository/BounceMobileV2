import 'package:bounce_patient_app/src/modules/book_session/controllers/controllers.dart';
import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/book_session/screens/upcoming_session_list_screen.dart';
import 'package:bounce_patient_app/src/shared/models/app_session.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/messenger.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/amount_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

Future<dynamic> showBookSessionPaymentSummaryBottomsheet({
  required BuildContext context,
  required Therapist therapist,
  required int amount,
}) {
  return showCustomBottomSheet(
    context,
    isDismissible: false,
    enableDrag: false,
    body: _Body(therapist: therapist, amount: amount),
  );
}

class _Body extends StatefulWidget {
  const _Body({required this.therapist, required this.amount});

  final Therapist therapist;
  final int amount;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  bool isLoading = false;

  void bookSession() async {
    final controller = context.read<BookSessionController>();
    final date = controller.selectedDate;
    final time = controller.selectedTime;
    final reason = controller.reason;
    final problemDesc = controller.problemDesc;
    final user = AppSession.user;

    if (time != null && reason != null && user != null) {
      final therapist = widget.therapist;

      try {
        setState(() => isLoading = true);
        await controller.bookSession(
          reason: reason,
          patientId: user.id,
          therapistId: therapist.id,
          price: widget.amount.toDouble(),
          time: time,
          date: date,
          problemDesc: problemDesc,
        );
        setState(() => isLoading = false);
        AppNavigator.removeAllUntil(context, const UpComingSessionListScreen());
        Messenger.success(message: 'Booking Successfull');
      } on Failure catch (e) {
        setState(() => isLoading = false);
        Messenger.error(message: e.message);
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetBody(
      height: 488.h,
      body: [
        isLoading
            ? SizedBox(
                height: 48.h,
              )
            : const Align(
                alignment: Alignment.centerRight,
                child: CloseButton(),
              ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Payment',
            style: AppText.bold700(context).copyWith(
              fontSize: 20.sp,
            ),
          ),
        ),
        SizedBox(height: 40.h),
        Align(
          alignment: Alignment.centerLeft,
          child: AmountText(amount: widget.amount, amountFontSize: 24.sp),
        ),
        SizedBox(height: 18.h),
        Text(
          'You are about to pay for your therapy session using your wallet balance.',
          style: AppText.titleStyle(context),
        ),
        const Spacer(),
        AppButton(
          label: 'Book Session',
          isLoading: isLoading,
          onTap: bookSession,
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
