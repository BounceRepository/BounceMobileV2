import 'package:bounce_patient_app/src/modules/book_session/controllers/controllers.dart';
import 'package:bounce_patient_app/src/modules/book_session/models/session.dart';
import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/book_session/widgets/select_availability_view.dart';
import 'package:bounce_patient_app/src/modules/book_session/widgets/select_date_view.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/utils/datetime_utils.dart';
import 'package:bounce_patient_app/src/shared/utils/messenger.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_loading_indicator.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class RescheduleSessionScreen extends StatefulWidget {
  const RescheduleSessionScreen(this.session, {super.key});

  final Session session;

  @override
  State<RescheduleSessionScreen> createState() => _RescheduleSessionScreenState();
}

class _RescheduleSessionScreenState extends State<RescheduleSessionScreen> {
  Therapist? therapist;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    context.read<BookSessionController>().init();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  void getTherapist() async {}

  void confirm() async {
    final controller = context.read<BookSessionController>();
    final selectedTime = controller.selectedTime;

    if (selectedTime == null) {
      return;
    }

    final selectedTimeInDateTime = DateTimeUtils.convertAMPMToDateTime(selectedTime);
    try {
      // await controller.rescheduleAppointment(
      //   sessionId: sessionId,
      //   startTime: startTime,
      //   endTime: endTime,
      // );
    } on Failure catch (e) {
      Messenger.error(message: e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const CustomAppBar(label: 'Reschedule'),
      body: isLoading
          ? const CustomLoadingIndicator()
          : therapist != null
              ? SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 56.h),
                      const SelectDateView(),
                      SizedBox(height: 48.h),
                      SelectAvailableTimeView(therapist: therapist!),
                      const Spacer(),
                      Padding(
                        padding: AppPadding.symetricHorizontalOnly,
                        child: Consumer<BookSessionController>(
                          builder: (context, controller, _) {
                            return AppButton(
                              label: 'Confirm Schedule',
                              isLoading: controller.isLoading,
                              onTap: confirm,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
    );
  }
}
