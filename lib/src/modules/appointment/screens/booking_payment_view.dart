import 'package:bounce_patient_app/src/modules/appointment/controllers/book_appointment_controller.dart';
import 'package:bounce_patient_app/src/modules/appointment/models/appointment.dart';
import 'package:bounce_patient_app/src/modules/appointment/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/dashboard/screens/dashboard_view.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/payment.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/payment_dto.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/flutterwave_payment_service.dart';
import 'package:bounce_patient_app/src/shared/models/datastore.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/notification_message.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/response_bottomsheets.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/select_payment_type_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BookingPaymentView extends StatefulWidget {
  const BookingPaymentView({Key? key, required this.therapist}) : super(key: key);

  final Therapist therapist;

  @override
  State<BookingPaymentView> createState() => _BookingPaymentViewState();
}

class _BookingPaymentViewState extends State<BookingPaymentView> {
  bool isLoading = false;
  PaymentType? selectedPaymentType;

  void bookSession() async {
    final selectedPaymentType = this.selectedPaymentType;

    if (selectedPaymentType != null) {
      if (selectedPaymentType == PaymentType.wallet) {
        Messenger.show(context, message: 'Wallet coming soon');
        return;
      }

      if (selectedPaymentType == PaymentType.card) {
        payWithCard();
      }
    }
  }

  void payWithCard() async {
    final paymentService = FlutterwavePaymentService(
      context: context,
      nextScreen: const DashboardView(),
    );

    try {
      setState(() => isLoading = true);
      final result = await _bookAppointment();

      if (result != null) {
        await paymentService.processTransaction(result);
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

  Future<PaymentDto?> _bookAppointment() async {
    final controller = context.read<BookAppointmentController>();
    final date = controller.selectedDate;
    final time = controller.selectedTime;
    final reason = controller.reason;
    final user = AppSession.user;

    if (date != null && time != null && reason != null && user != null) {
      final therapist = widget.therapist;

      try {
        final trxRef = await controller.bookAppointment(
          appointmentType: AppointmentType.audio,
          paymentType: PaymentType.card,
          reason: reason,
          patientId: user.id,
          therapistId: therapist.id,
          price: therapist.serviceChargePerHour.toDouble(),
          time: time,
          date: date,
        );

        return PaymentDto(
          trxRef: trxRef,
          customerName: user.fullName,
          email: user.email,
          amount: therapist.serviceChargePerHour,
          narration: 'Appointment Booking',
          message: 'Payment for session with ${therapist.fullName} and ${user.fullName}',
        );
      } on Failure {
        rethrow;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.symetricHorizontalOnly,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40.h),
          Text(
            'Choose Payment',
            style: AppText.titleStyle(context),
          ),
          SizedBox(height: 20.h),
          SelectPaymentTypeView(
            onSelect: (type) {
              selectedPaymentType = type;
            },
          ),
          SizedBox(height: 360.h),
          AppButton(
            label: 'Book Session',
            isLoading: isLoading,
            onTap: bookSession,
          ),
        ],
      ),
    );
  }
}
