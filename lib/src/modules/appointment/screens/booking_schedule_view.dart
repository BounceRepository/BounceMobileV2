import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/success_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/input/custom_textfield.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_child_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingScheduleView extends StatelessWidget {
  const BookingScheduleView({Key? key}) : super(key: key);

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
          const _AvailableTimeSection(),
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
                // showSuccessBottomsheet(
                //   context,
                //   title: '',
                //   desc: '',
                //   onTap: () {},
                // );
              },
            ),
          ),
          SizedBox(height: gap),
        ],
      ),
    );
  }
}

class _DateSelectionSection extends StatelessWidget {
  const _DateSelectionSection({Key? key}) : super(key: key);

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
        SizedBox(height: 20.h),
      ],
    );
  }
}

class _AvailableTimeSection extends StatelessWidget {
  const _AvailableTimeSection({Key? key}) : super(key: key);

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
          SizedBox(height: 20.h),
          Wrap(
            spacing: 22.w,
            runSpacing: 12.h,
            children: List.generate(9, (index) => const _CustomButton()),
          ),
        ],
      ),
    );
  }
}

class _ReasonForTherapySection extends StatelessWidget {
  const _ReasonForTherapySection({Key? key}) : super(key: key);

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
        //SizedBox(height: 20.h),
        SizedBox(
          height: 40.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: AppPadding.symetricHorizontalOnly,
            itemCount: 6,
            itemBuilder: (context, index) {
              return const _CustomButton();
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
  const _CustomButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 22.5.w),
      decoration: BoxDecoration(
        color: const Color(0xffFEFEFE),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: AppColors.boxshadow4,
      ),
      child: Text(
        '08:00 AM',
        style: AppText.bold400(context).copyWith(
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
