import 'package:bounce_patient_app/src/modules/book_session/controllers/controllers.dart';
import 'package:bounce_patient_app/src/modules/book_session/widgets/custom_horizontal_calendar_picker.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectDateView extends StatelessWidget {
  const SelectDateView({Key? key, required this.therapistId}) : super(key: key);

  final int therapistId;

  void getAvailableBookingTimeListForTherapist(BuildContext context) async {
    final controller = context.read<BookSessionController>();

    try {
      await controller.getAvailableBookingTimeListForTherapist(
          therapistId: therapistId);
    } on Failure {
      controller.setFailure(Failure('Failed to get available time for this day'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: AppPadding.horizontal),
          child: Text(
            'Preferred Date',
            style: AppText.titleStyle(context),
          ),
        ),
        Consumer<BookSessionController>(
          builder: (context, controller, _) {
            return CustomHorizontalCalendarPicker(
              selectedDate: controller.selectedDate,
              onSelectDate: (date) {
                controller.selectedDate = date;
                getAvailableBookingTimeListForTherapist(context);
              },
            );
          },
        ),
      ],
    );
  }
}
