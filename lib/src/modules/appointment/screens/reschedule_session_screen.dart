import 'package:bounce_patient_app/src/modules/appointment/services/services.dart';
import 'package:bounce_patient_app/src/modules/appointment/widgets/select_availability_view.dart';
import 'package:bounce_patient_app/src/modules/appointment/widgets/select_date_view.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class RescheduleSessionScreen extends StatelessWidget {
  const RescheduleSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const CustomAppBar(label: 'Reschedule'),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 56.h),
            const SelectDateView(),
            SizedBox(height: 48.h),
            SelectAvailableTimeView(therapist: therapist),
            const Spacer(),
            Padding(
              padding: AppPadding.symetricHorizontalOnly,
              child: AppButton(
                label: 'Confirm Schedule',
                onTap: () {},
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}