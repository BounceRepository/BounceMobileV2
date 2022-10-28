import 'package:bounce_patient_app/src/modules/appointment/controllers/controllers.dart';
import 'package:bounce_patient_app/src/modules/appointment/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/appointment/widgets/custom_chip_button.dart';
import 'package:bounce_patient_app/src/modules/appointment/widgets/select_availability_view.dart';
import 'package:bounce_patient_app/src/modules/appointment/widgets/select_date_view.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/input/custom_textfield.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_child_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BookingScheduleView extends StatelessWidget {
  const BookingScheduleView({Key? key, required this.therapist}) : super(key: key);

  final Therapist therapist;

  @override
  Widget build(BuildContext context) {
    final gap = 40.h;

    return CustomChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: gap),
          const SelectDateView(),
          SizedBox(height: gap),
          SelectAvailableTimeView(therapist: therapist),
          SizedBox(height: gap),
          const _ReasonForTherapySection(),
          SizedBox(height: gap),
          const _AddNoteSection(),
          SizedBox(height: gap),
          Padding(
            padding: AppPadding.symetricHorizontalOnly,
            child: AppButton(
              label: 'Confirmation',
              onTap: () {
                DefaultTabController.of(context)!.animateTo(1);
              },
            ),
          ),
          SizedBox(height: gap),
        ],
      ),
    );
  }
}

class _ReasonForTherapySection extends StatefulWidget {
  const _ReasonForTherapySection({Key? key}) : super(key: key);

  @override
  State<_ReasonForTherapySection> createState() => _ReasonForTherapySectionState();
}

class _ReasonForTherapySectionState extends State<_ReasonForTherapySection> {
  int selectedIndex = 0;
  final reasons = [
    'Addiction',
    'Self-esteem',
    'Confidence',
    'Anxiety',
    'Stress',
  ];

  @override
  void initState() {
    super.initState();
    context.read<BookAppointmentController>().reason = reasons[selectedIndex];
  }

  void onSelect(int index) {
    context.read<BookAppointmentController>().reason = reasons[index];

    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: AppPadding.horizontal),
          child: Text(
            'Reason for Therapy',
            style: AppText.titleStyle(context),
          ),
        ),
        SizedBox(
          height: 55.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: AppPadding.symetricHorizontalOnly,
            itemCount: reasons.length,
            itemBuilder: (context, index) {
              final reason = reasons[index];
              return CustomChipButton(
                height: 40.h,
                title: reason,
                isSelected: index == selectedIndex,
                onTap: () => onSelect(index),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(width: 12.w);
            },
          ),
        ),
      ],
    );
  }
}

class _AddNoteSection extends StatefulWidget {
  const _AddNoteSection({Key? key}) : super(key: key);

  @override
  State<_AddNoteSection> createState() => _AddNoteSectionState();
}

class _AddNoteSectionState extends State<_AddNoteSection> {
  late final TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    noteController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.symetricHorizontalOnly,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add a Note (Optional)',
            style: AppText.titleStyle(context),
          ),
          SizedBox(height: 20.h),
          CustomTextField(
            controller: noteController,
            maxLines: 4,
            hintText: 'Enter your complaint or any additional information here.',
          ),
        ],
      ),
    );
  }
}
