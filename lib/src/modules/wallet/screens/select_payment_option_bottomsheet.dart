import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:flutter/material.dart';

Future<dynamic> showSelectPaymentOptionBottomsheet({
  required BuildContext context,
}) {
  return showCustomBottomSheet(
    context,
    body: const _SelectPaymentOptionBody(),
  );
}

class _SelectPaymentOptionBody extends StatelessWidget {
  const _SelectPaymentOptionBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}