import 'package:bounce_patient_app/src/modules/auth/screens/sign_in_screen.dart';
import 'package:bounce_patient_app/src/modules/dashboard/controllers/mood_controller.dart';
import 'package:bounce_patient_app/src/modules/dashboard/models/mood.dart';
import 'package:bounce_patient_app/src/modules/dashboard/screens/dashboard_view.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/extensions/string.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/messenger.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_child_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SelectMoodsScreen extends StatefulWidget {
  const SelectMoodsScreen({Key? key}) : super(key: key);

  @override
  State<SelectMoodsScreen> createState() => _SelectMoodsScreenState();
}

class _SelectMoodsScreenState extends State<SelectMoodsScreen> {
  bool showMore = false;

  void loadMore() {
    showMore = true;
    setState(() {});
  }

  void submit() async {
    final controller = context.read<MoodController>();

    if (controller.selectedMoodList.isEmpty) {
      AppNavigator.to(context, const DashboardView());
      return;
    }

    try {
      await controller.saveSelectedMoodListToDB();
      AppNavigator.to(context, const DashboardView());
    } on Failure catch (e) {
      Messenger.error(message: e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        AppNavigator.to(context, const SignInScreen());
        return Future.value(true);
      },
      child: Scaffold(
        body: SafeArea(
          child: CustomChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.horizontal,
              vertical: 20.h,
            ),
            child: Column(
              children: [
                SvgPicture.asset(
                  AuthIcons.symptoms,
                  width: 162.43.w,
                  height: 152.h,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 48.h),
                Text(
                  'How are you feeling today?',
                  style: AppText.bold700(context).copyWith(
                    fontSize: 16.sp,
                    color: AppColors.textBrown,
                  ),
                ),
                SizedBox(height: 7.h),
                Text(
                  'You can choose as many as you like, we will  show recommended therapist, meditations and articles according to this.',
                  textAlign: TextAlign.center,
                  style: AppText.bold300(context).copyWith(
                    fontSize: 14.sp,
                    height: 1.5.h,
                    color: AppColors.textBrown,
                  ),
                ),
                SizedBox(height: 32.h),
                Consumer<MoodController>(
                  builder: (context, controller, _) {
                    final moods = controller.moodList;
                    return Wrap(
                      spacing: 8.w,
                      runSpacing: 16.h,
                      children: List.generate(showMore ? moods.length : 12, (index) {
                        final mood = moods[index];
                        return _MoodButton(mood);
                      }),
                    );
                  },
                ),
                showMore
                    ? const SizedBox.shrink()
                    : Column(
                        children: [
                          SizedBox(height: 15.h),
                          SizedBox(
                            width: 100.w,
                            child: AppButton(
                              label: 'See More',
                              labelColor: AppColors.primary,
                              backgroundColor: Colors.transparent,
                              onTap: loadMore,
                            ),
                          ),
                        ],
                      ),
                SizedBox(height: 24.h),
                Consumer<MoodController>(
                  builder: (context, controller, _) {
                    return AppButton(
                      label: 'Done',
                      isLoading: controller.isLoading,
                      onTap: submit,
                    );
                  },
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MoodButton extends StatelessWidget {
  const _MoodButton(this.mood, {Key? key}) : super(key: key);

  final Mood mood;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<MoodController>().select(mood),
      child: Container(
        width: 77.17.w,
        padding: EdgeInsets.symmetric(
          horizontal: 7.w,
          vertical: 10.42.h,
        ),
        decoration: BoxDecoration(
          color: mood.isSelected ? AppColors.primary : AppColors.grey,
          borderRadius: BorderRadius.circular(7.r),
        ),
        child: Column(
          children: [
            Image.asset(
              mood.icon,
              height: 50.h,
              width: 50.h,
              fit: BoxFit.cover,
              color: mood.isSelected ? Colors.white : AppColors.grey5,
            ),
            SizedBox(height: 10.h),
            Text(
              mood.name.toTitleCase,
              style: AppText.bold500(context).copyWith(
                fontSize: 9.sp,
                color: mood.isSelected ? Colors.white : AppColors.lightText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
