import 'package:bounce_patient_app/src/modules/book_session/controllers/controllers.dart';
import 'package:bounce_patient_app/src/modules/book_session/models/session.dart';
import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/book_session/screens/screens.dart';
import 'package:bounce_patient_app/src/modules/book_session/widgets/select_availability_view.dart';
import 'package:bounce_patient_app/src/modules/book_session/widgets/select_date_view.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/utils/messenger.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_loading_indicator.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/error_view.dart';
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
  Therapist? _therapist;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    context.read<BookSessionController>().init();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getTherapist();
    });
  }

  void getTherapist() async {
    final controller = context.read<BookSessionController>();

    try {
      _therapist = await controller.getOneTherapist(widget.session.therapistId);
    } on Failure catch (e) {
      controller.setFailure(e);
    }
  }

  void confirm() async {
    final controller = context.read<BookSessionController>();
    final selectedTime = controller.selectedTime;

    if (selectedTime == null) {
      return;
    }

    try {
      setState(() => isLoading = true);
      await controller.rescheduleAppointment(
        sessionId: widget.session.id,
        startTime: selectedTime,
        date: controller.selectedDate,
      );
      getAllSessions();
      setState(() => isLoading = false);
      AppNavigator.to(context, const UpComingSessionListScreen());
      Messenger.success(message: 'Session reschedule success');
    } on Failure catch (e) {
      setState(() => isLoading = false);
      Messenger.error(message: e.message);
    }
  }

  void getAllSessions() async {
    final controller = context.read<SessionListController>();

    try {
      await Future.wait([
        controller.getAllSession(),
        controller.getUpComingSessions(),
      ]);
    } on Failure {
      Messenger.error(message: 'Failed to refetch sessions');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: const CustomAppBar(label: 'Reschedule'),
        body: Consumer<BookSessionController>(
          builder: (context, controller, _) {
            if (controller.isLoading) {
              return const CustomLoadingIndicator();
            }

            final error = controller.failure;
            if (error != null) {
              return ErrorScreen(error: error, retry: getTherapist);
            }

            final therapist = _therapist;
            if (therapist == null) {
              return const SizedBox.shrink();
            }

            return SizedBox(
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
                      isLoading: isLoading,
                      onTap: confirm,
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            );
          },
        ));
  }
}
