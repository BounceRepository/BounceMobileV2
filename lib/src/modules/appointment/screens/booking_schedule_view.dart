import 'package:bounce_patient_app/src/modules/appointment/controllers/controllers.dart';
import 'package:bounce_patient_app/src/modules/appointment/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/appointment/widgets/custom_horizontal_calendar_picker.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
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
          const _DateSelectionSection(),
          SizedBox(height: gap),
          _AvailableTimeSection(therapist: therapist),
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

class _DateSelectionSection extends StatefulWidget {
  const _DateSelectionSection({Key? key}) : super(key: key);

  @override
  State<_DateSelectionSection> createState() => _DateSelectionSectionState();
}

class _DateSelectionSectionState extends State<_DateSelectionSection> {
  @override
  void initState() {
    super.initState();
    context.read<SessionBookingController>().selectedDate = DateTime.now();
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
            context.read<SessionBookingController>().selectedDate = date;
          },
        ),
      ],
    );
  }
}

class _AvailableTimeSection extends StatefulWidget {
  const _AvailableTimeSection({Key? key, required this.therapist}) : super(key: key);

  final Therapist therapist;

  @override
  State<_AvailableTimeSection> createState() => _AvailableTimeSectionState();
}

class _AvailableTimeSectionState extends State<_AvailableTimeSection> {
  int selectedIndex = 0;
  late List<String> availableTimes;

  @override
  void initState() {
    super.initState();
    availableTimes = widget.therapist.workingHours.availableTime;
    context.read<SessionBookingController>().selectedTime = availableTimes[selectedIndex];
  }

  void onSelect(int index) {
    context.read<SessionBookingController>().selectedTime = availableTimes[index];

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
                return _CustomButton(
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
    context.read<SessionBookingController>().reason = reasons[selectedIndex];
  }

  void onSelect(int index) {
    context.read<SessionBookingController>().reason = reasons[index];

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
              return _CustomButton(
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

class _CustomButton extends StatelessWidget {
  const _CustomButton({
    Key? key,
    required this.title,
    required this.isSelected,
    this.height,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final bool isSelected;
  final double? height;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        margin: EdgeInsets.symmetric(vertical: 6.h),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 22.5.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : const Color(0xffFEFEFE),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: AppColors.boxshadow4,
        ),
        child: Text(
          title,
          style: AppText.bold400(context).copyWith(
            fontSize: 12.sp,
            color: isSelected ? Colors.white : null,
          ),
        ),
      ),
    );
  }
}
