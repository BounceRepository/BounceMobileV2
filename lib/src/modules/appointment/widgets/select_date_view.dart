import 'package:bounce_patient_app/src/modules/appointment/controllers/controllers.dart';
import 'package:bounce_patient_app/src/modules/appointment/widgets/custom_horizontal_calendar_picker.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectDateView extends StatefulWidget {
  const SelectDateView({Key? key}) : super(key: key);

  @override
  State<SelectDateView> createState() => _SelectDateViewState();
}

class _SelectDateViewState extends State<SelectDateView> {
  @override
  void initState() {
    super.initState();
    context.read<BookAppointmentController>().selectedDate = DateTime.now();
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
        CustomHorizontalCalendarPicker(
          onSelectDate: (date) {
            context.read<BookAppointmentController>().selectedDate = date;
          },
        ),
      ],
    );
  }
}
