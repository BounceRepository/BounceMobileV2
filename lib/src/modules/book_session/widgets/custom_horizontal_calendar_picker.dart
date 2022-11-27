import 'package:bounce_patient_app/src/shared/helper_functions/datetime_utils.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef OnSelecteDate = Function(DateTime date);

class CustomHorizontalCalendarPicker extends StatefulWidget {
  const CustomHorizontalCalendarPicker({
    super.key,
    required this.onSelectDate,
    required this.selectedDate,
  });

  final DateTime selectedDate;
  final OnSelecteDate onSelectDate;

  @override
  State<CustomHorizontalCalendarPicker> createState() =>
      _CustomHorizontalCalendarPickerState();
}

class _CustomHorizontalCalendarPickerState extends State<CustomHorizontalCalendarPicker> {
  final startDate = DateTime.now();
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 105.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(left: 10.w, right: AppPadding.horizontal),
        itemBuilder: (context, index) {
          final date = startDate.add(Duration(days: index));

          return _CalendarItem(
            date: date,
            isSeleted: date.day == selectedDate.day,
            onTap: () => onDatePressed(index),
          );
        },
      ),
    );
  }

  void onDatePressed(int index) {
    final date = startDate.add(Duration(days: index));
    int checkDate = date.difference(DateTime.now()).inDays;
    if (checkDate >= 0) {
      widget.onSelectDate(date);
      setState(() {
        selectedDate = date;
      });
    }
  }
}

class _CalendarItem extends StatelessWidget {
  const _CalendarItem({
    required this.isSeleted,
    required this.date,
    required this.onTap,
  });

  final bool isSeleted;
  final DateTime date;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSeleted ? AppColors.primary : const Color(0xffFEFEFE),
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: AppColors.boxshadow4,
        ),
        margin: EdgeInsets.only(
          top: 12.w,
          right: 6.w,
          left: 6.w,
          bottom: 12.w,
        ),
        padding: EdgeInsets.only(
          top: 8.h,
          bottom: 12.h,
          right: 20.w,
          left: 20.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateTimeUtils.getDayOfMonth(date),
              style: AppText.bold700(context).copyWith(
                fontSize: 14.sp,
                color: isSeleted ? Colors.white : AppColors.lightText,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              DateTimeUtils.getDayOfWeek(date).toUpperCase(),
              style: AppText.bold400(context).copyWith(
                fontSize: 12.sp,
                color: isSeleted ? Colors.white : AppColors.lightText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
