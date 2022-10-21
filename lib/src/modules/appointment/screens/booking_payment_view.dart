import 'package:bounce_patient_app/src/modules/appointment/controllers/book_appointment_controller.dart';
import 'package:bounce_patient_app/src/modules/appointment/models/appointment.dart';
import 'package:bounce_patient_app/src/modules/appointment/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/dashboard/screens/dashboard_view.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/payment.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/payment_dto.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/flutterwave_payment_service.dart';
import 'package:bounce_patient_app/src/shared/models/datastore.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/notification_message.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/response_bottomsheets.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
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
  int selectedIndex = 0;

  void onSelect(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void bookSession() async {
    if (selectedIndex == 0) {
      Messenger.show(context, message: 'Wallet coming soon');
      return;
    }

    _payWithCard();
  }

  void _payWithCard() async {
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
          _Tile(
            title: 'Pay with Wallet',
            isSelected: selectedIndex == 0,
            onTap: () => onSelect(0),
          ),
          SizedBox(height: 12.h),
          _Tile(
            title: 'Pay with Card',
            isSelected: selectedIndex == 1,
            onTap: () => onSelect(1),
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

class _Tile extends StatelessWidget {
  const _Tile({
    Key? key,
    required this.title,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  final String title;
  final Function() onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 18.4.w),
        decoration: BoxDecoration(
          color: const Color(0xffFEFEFE),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: AppColors.boxshadow4,
        ),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked_outlined,
              size: 20.sp,
              color: AppColors.primary,
            ),
            SizedBox(width: 58.4.w),
            Text(
              title,
              style: AppText.bold400(context).copyWith(
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
