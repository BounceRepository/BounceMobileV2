import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBar(
        backgroundColor: Colors.transparent,
        label: 'Happy',
      ),
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Padding(
            padding: AppPadding.symetricHorizontalOnly,
            child: Column(
              children: [
                SizedBox(height: 28.h),
                SizedBox(
                  width: 292.w,
                  child: Text(
                    '“Happiness is a journey not a destination, enjoy it.”',
                    textAlign: TextAlign.center,
                    style: AppText.bold300(context).copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                const _MusicFrame(),
                SizedBox(height: 20.h),
                Text(
                  'Fall Asleep Fast',
                  textAlign: TextAlign.center,
                  style: AppText.bold500(context).copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'John Deepp',
                  textAlign: TextAlign.center,
                  style: AppText.bold500(context).copyWith(
                    fontSize: 12.sp,
                  ),
                ),
                const Spacer(),
                const _PlayTrackSection(),
                const Spacer(),
                const _PlayerControlsSection(),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MusicFrame extends StatelessWidget {
  const _MusicFrame();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 292.w,
      height: 292.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.secondary,
        boxShadow: AppColors.boxshadow4,
      ),
      child: Container(
        width: 252.h,
        height: 252.h,
        margin: EdgeInsets.all(20.sp),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

class _PlayTrackSection extends StatelessWidget {
  const _PlayTrackSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        time(context, '5:20'),
        const Expanded(child: CustomMusicTrack()),
        time(context, '15:28'),
      ],
    );
  }

  Widget time(BuildContext context, String t) {
    return Text(
      t,
      style: AppText.bold500(context).copyWith(
        fontSize: 10.sp,
      ),
    );
  }
}

class CustomMusicTrack extends StatefulWidget {
  const CustomMusicTrack({super.key});

  @override
  State<CustomMusicTrack> createState() => _CustomMusicTrackState();
}

class _CustomMusicTrackState extends State<CustomMusicTrack> {
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _currentSliderValue,
      max: 100,
      activeColor: AppColors.primary,
      inactiveColor: AppColors.grey,
      label: _currentSliderValue.round().toString(),
      onChanged: (double value) {
        setState(() {
          _currentSliderValue = value;
        });
      },
    );
  }
}

class _PlayerControlsSection extends StatelessWidget {
  const _PlayerControlsSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        button(
          icon: MusicIcons.previous,
          size: 50.h,
          iconSize: 24.h,
        ),
        SizedBox(width: 20.w),
        button(
          icon: MusicIcons.play,
          size: 72.h,
          iconSize: 32.h,
          showShadow: true,
        ),
        SizedBox(width: 20.w),
        button(
          icon: MusicIcons.next,
          size: 50.h,
          iconSize: 24.h,
        ),
      ],
    );
  }

  Widget button({
    required String icon,
    required double iconSize,
    required double size,
    bool showShadow = false,
  }) {
    return Container(
      height: size,
      width: size,
      padding: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: showShadow ? AppColors.boxshadow4 : null,
      ),
      child: SvgPicture.asset(
        icon,
        height: iconSize,
        width: iconSize,
        fit: BoxFit.cover,
        color: AppColors.lightText,
      ),
    );
  }
}
