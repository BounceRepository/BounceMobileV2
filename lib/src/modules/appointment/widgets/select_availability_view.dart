import 'package:bounce_patient_app/src/modules/appointment/controllers/controllers.dart';
import 'package:bounce_patient_app/src/modules/appointment/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/appointment/widgets/custom_chip_button.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SelectAvailableTimeView extends StatefulWidget {
  const SelectAvailableTimeView({Key? key, required this.therapist}) : super(key: key);

  final Therapist therapist;

  @override
  State<SelectAvailableTimeView> createState() => _SelectAvailableTimeViewState();
}

class _SelectAvailableTimeViewState extends State<SelectAvailableTimeView> {
  int selectedIndex = 0;
  late List<String> availableTimes;

  @override
  void initState() {
    super.initState();
    availableTimes = widget.therapist.workingHours.availableTime;
    context.read<BookAppointmentController>().selectedTime =
        availableTimes[selectedIndex];
  }

  void onSelect(int index) {
    context.read<BookAppointmentController>().selectedTime = availableTimes[index];

    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.symetricHorizontalOnly,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available Time',
            style: AppText.titleStyle(context),
          ),
          Wrap(
            spacing: 22.w,
            children: List.generate(
              availableTimes.length,
              (index) {
                final time = availableTimes[index];
                return CustomChipButton(
                  width: 100.w,
                  title: time,
                  isSelected: index == selectedIndex,
                  onTap: () => onSelect(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
