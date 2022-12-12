import 'package:bounce_patient_app/src/modules/book_session/controllers/controllers.dart';
import 'package:bounce_patient_app/src/modules/book_session/models/session.dart';
import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/dashboard/screens/dashboard_view.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/payment.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/payment_dto.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/impls/flutterwave_payment_service.dart';
import 'package:bounce_patient_app/src/shared/extensions/string.dart';
import 'package:bounce_patient_app/src/shared/models/app_session.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/messenger.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/response_bottomsheets.dart';
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
  PaymentOption? selectedPaymentOption;

  void payWithCard() async {
    try {
      setState(() => isLoading = true);
      final paymentDTO = await _bookSession();

      if (paymentDTO != null) {
        final paymentService = FlutterwavePaymentService(context: context);
        final response = await paymentService.processTransaction(
          paymentDto: paymentDTO,
          paymentOption: PaymentOption.card,
        );
        if (response != null) {
          await confirmPayment(response.value);
        }
      }
      setState(() => isLoading = false);
    } on Failure {
      setState(() => isLoading = false);
      showErrorBottomsheet(
        context,
        desc:
            'Your prefered doctor would be not be available for this session, please choose another doctor from our top therapists.',
      );
    }
  }

  Future<PaymentDto?> _bookSession() async {
    final controller = context.read<BookSessionController>();
    final date = controller.selectedDate;
    final time = controller.selectedTime;
    final reason = controller.reason;
    final user = AppSession.user;

    if (time != null && reason != null && user != null) {
      final therapist = widget.therapist;

      try {
        final trxRef = await controller.bookSession(
          appointmentType: SessionType.audio,
          paymentType: PaymentOption.card,
          reason: reason,
          patientId: user.id,
          therapistId: therapist.id,
          price: widget.amount.toDouble(),
          time: time,
          date: date,
        );

        return PaymentDto(
          trxRef: trxRef,
          customerName: user.fullName,
          email: user.email,
          amount: widget.amount,
          narration: 'Appointment Booking',
          message: 'Payment for session with ${therapist.fullName} and ${user.fullName}',
        );
      } on Failure {
        rethrow;
      }
    }
    return null;
  }

  Future<void> confirmPayment(String trxRef) async {
    final controller = context.read<BookSessionController>();

    try {
      setState(() => isLoading = true);
      await controller.confirmAppointment(trxRef);
      AppNavigator.removeAllUntil(context, const DashboardView());
      Messenger.success(message: 'Booking Successfull');
      setState(() => isLoading = false);
    } on Failure catch (e) {
      setState(() => isLoading = false);
      showErrorBottomsheet(
        context,
        desc: e.message.toTitleCase,
        onTap: () {
          AppNavigator.removeAllUntil(context, const DashboardView());
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetBody(
      height: 488.h,
      body: [
        const BottomSheetTitle('Payment'),
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
          onTap: payWithCard,
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
