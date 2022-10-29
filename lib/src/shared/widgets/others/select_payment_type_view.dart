import 'package:bounce_patient_app/src/modules/wallet/models/payment.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectPaymentTypeView extends StatefulWidget {
  const SelectPaymentTypeView({
    super.key,
    required this.onSelect,
  });

  final Function(PaymentType type) onSelect;

  @override
  State<SelectPaymentTypeView> createState() => _SelectPaymentTypeViewState();
}

class _SelectPaymentTypeViewState extends State<SelectPaymentTypeView> {
  PaymentType? selectedPaymentType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Tile(
          title: 'Pay with Wallet',
          isSelected: selectedPaymentType == PaymentType.wallet,
          onTap: () {
            selectedPaymentType = PaymentType.wallet;
            widget.onSelect(PaymentType.wallet);
            setState(() {});
          },
        ),
        SizedBox(height: 12.h),
        _Tile(
          title: 'Pay with Card',
          isSelected: selectedPaymentType == PaymentType.card,
          onTap: () {
            selectedPaymentType = PaymentType.card;
            widget.onSelect(PaymentType.card);
            setState(() {});
          },
        ),
      ],
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
