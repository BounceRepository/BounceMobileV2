import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/book_session/screens/book_session_payment_summary_bottomsheet.dart';
import 'package:bounce_patient_app/src/modules/book_session/screens/screens.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/amount_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingPaymentView extends StatelessWidget {
  const BookingPaymentView({Key? key, required this.therapist}) : super(key: key);

  final Therapist therapist;

  @override
  Widget build(BuildContext context) {
    return _PayNowView(therapist);
  }
}

class _TopUpView extends StatelessWidget {
  const _TopUpView(this.therapist);

  final Therapist therapist;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.symetricHorizontalOnly,
      child: Column(
        children: [
          SizedBox(height: 40.h),
          Text(
            'Top up your ThriveX wallet and get 5% off your next 2 sessions when you pay with your wallet!',
            textAlign: TextAlign.center,
            style: AppText.titleStyle(context),
          ),
          const Spacer(),
          AmountChargedTile(
              title: 'Service charge', amount: therapist.serviceChargePerHour),
          SizedBox(height: 22.h),
          AppButton(
            label: 'Top Up Now',
            onTap: () {},
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}

class _PayNowView extends StatelessWidget {
  const _PayNowView(this.therapist);

  final Therapist therapist;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.symetricHorizontalOnly,
      child: Column(
        children: [
          SizedBox(height: 40.h),
          Text(
            'You will be charged from your ThriveX wallet!',
            textAlign: TextAlign.center,
            style: AppText.titleStyle(context),
          ),
          const Spacer(),
          AmountChargedTile(
              title: 'Service charge', amount: therapist.serviceChargePerHour),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Discount',
                style: AppText.bold400(context).copyWith(
                  fontSize: 16.sp,
                ),
              ),
              AmountText(
                amount: 250,
                amountFontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          SizedBox(height: 52.h),
          AmountChargedTile(
              title: 'Total charge', amount: therapist.serviceChargePerHour + 250),
          SizedBox(height: 30.h),
          AppButton(
            label: 'Pay Now',
            onTap: () => showBookSessionPaymentSummaryBottomsheet(
              context: context,
              therapist: therapist,
              amount: therapist.serviceChargePerHour + 250,
            ),
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
