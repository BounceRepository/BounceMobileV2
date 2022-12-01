import 'package:bounce_patient_app/src/modules/dashboard/controllers/mood_controller.dart';
import 'package:bounce_patient_app/src/modules/dashboard/models/mood.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MoodIconsView extends StatefulWidget {
  const MoodIconsView({Key? key}) : super(key: key);

  @override
  State<MoodIconsView> createState() => _MoodIconsViewState();
}

class _MoodIconsViewState extends State<MoodIconsView> {
  List<Mood> moods = [];

  @override
  void initState() {
    super.initState();
    final controller = context.read<MoodController>();
    moods = controller.moodList.where((element) => element.isSelected).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (moods.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppPadding.symetricHorizontalOnly,
          child: Text(
            'How are you feeling today ?',
            style: AppText.bold500(context).copyWith(
              fontSize: 16.sp,
            ),
          ),
        ),
        SizedBox(height: 20.h),
        SizedBox(
          height: 100.h,
          child: ListView.separated(
            itemCount: moods.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: AppPadding.symetricHorizontalOnly,
            itemBuilder: (context, index) {
              final mood = moods[index];
              return _Button(mood);
            },
            separatorBuilder: (context, index) {
              return SizedBox(width: 20.w);
            },
          ),
        ),
      ],
    );
  }
}

Future<dynamic> showMoodBottomsheet(
  BuildContext context, {
  required Mood mood,
}) {
  return showCustomBottomSheet(
    context,
    body: MoodBottomSheet(mood),
  );
}

class MoodBottomSheet extends StatelessWidget {
  const MoodBottomSheet(this.mood, {super.key});

  final Mood mood;

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetBody(
      body: [
        const BottomSheetDragger(),
        SizedBox(height: 40.h),
        _Button(mood, isTappable: true),
        SizedBox(height: 20.h),
        Text(
          '“You are doing very well for yourself so be happy for this moment, cease it and make the most of it because this moment is your life”...',
          textAlign: TextAlign.center,
          style: AppText.bold400(context).copyWith(
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 60.h),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button(this.mood, {this.isTappable = true});

  final Mood mood;
  final bool isTappable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isTappable
          ? () {
              showMoodBottomsheet(context, mood: mood);
            }
          : null,
      child: SizedBox(
        height: 90.h,
        width: 55.w,
        child: Column(
          children: [
            Container(
              height: 60.h,
              width: 60.h,
              padding: EdgeInsets.symmetric(
                vertical: 14.h,
                horizontal: 12.w,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Image.asset(
                mood.icon,
                height: 33.18.h,
                width: 33.18.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: Text(
                mood.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppText.bold400(context).copyWith(
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
