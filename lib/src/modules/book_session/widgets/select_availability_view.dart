import 'package:bounce_patient_app/src/modules/book_session/controllers/controllers.dart';
import 'package:bounce_patient_app/src/modules/book_session/widgets/custom_chip_button.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SelectAvailableTimeView extends StatefulWidget {
  const SelectAvailableTimeView({Key? key, required this.therapistId}) : super(key: key);

  final int therapistId;

  @override
  State<SelectAvailableTimeView> createState() => _SelectAvailableTimeViewState();
}

class _SelectAvailableTimeViewState extends State<SelectAvailableTimeView> {
  int selectedIndex = 0;
  bool isLoading = false;
  Failure? failure;

  @override
  void initState() {
    super.initState();
    setSelectedTime();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getAvailableBookingTimeListForTherapist();
    });
  }

  void getAvailableBookingTimeListForTherapist() async {
    final controller = context.read<BookSessionController>();

    try {
      await controller.getAvailableBookingTimeListForTherapist(
          therapistId: widget.therapistId);
      controller.selectedTime = controller.availableTimeList[selectedIndex];
    } on Failure catch (e) {
      failure = e;
      setState(() {});
    }
  }

  void setSelectedTime() {
    final controller = context.read<BookSessionController>();
    final selectedTime = controller.selectedTime;

    if (selectedTime != null) {
      selectedIndex = controller.availableTimeList
          .indexWhere((element) => element.toLowerCase() == selectedTime.toLowerCase());
    }
  }

  void onSelect(int index) {
    final controller = context.read<BookSessionController>();
    controller.selectedTime = controller.availableTimeList[index];
    selectedIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppPadding.symetricHorizontalOnly,
          child: Text(
            'Available Time',
            style: AppText.titleStyle(context),
          ),
        ),
        SizedBox(height: 20.h),
        Consumer<BookSessionController>(
          builder: (context, controller, _) {
            if (!controller.isLoading) {
              return SizedBox(
                height: 110.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.scale(
                      scale: 0.6,
                      child: const CircularProgressIndicator.adaptive(),
                    ),
                    SizedBox(height: 10.h),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Loading therapist available time...',
                        textAlign: TextAlign.center,
                        style: AppText.bold500(context).copyWith(
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            final error = failure;
            if (error != null) {
              return SizedBox(
                height: 110.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error,
                      color: Colors.black,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      error.message,
                      textAlign: TextAlign.center,
                      style: AppText.bold500(context),
                    ),
                    SizedBox(height: 10.h),
                    TextButton(
                      onPressed: getAvailableBookingTimeListForTherapist,
                      child: Text(
                        'Reload',
                        style: AppText.bold400(context).copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            final availableTimes = controller.availableTimeList;
            return GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              padding: EdgeInsets.only(
                left: AppPadding.horizontal,
                right: AppPadding.horizontal,
                bottom: 10.h,
              ),
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 100.w / 40.h,
              crossAxisSpacing: 22.w,
              mainAxisSpacing: 12.h,
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
            );
          },
        ),
      ],
    );
  }
}
