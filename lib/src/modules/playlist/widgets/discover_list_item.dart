import 'package:bounce_patient_app/src/modules/playlist/screens/player_screen.dart';
import 'package:bounce_patient_app/src/modules/playlist/widgets/play_button.dart';
import 'package:bounce_patient_app/src/shared/assets/images.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscoverListItem extends StatelessWidget {
  const DiscoverListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.to(context, const PlayerScreen());
      },
      child: Container(
        width: 344.w,
        height: 176.h,
        margin: EdgeInsets.only(bottom: 36.h),
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          image: const DecorationImage(
            image: AssetImage(AppImages.playlistAlbum),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _TagButton(),
            const Spacer(),
            const Align(
              alignment: Alignment.center,
              child: PlayButton(),
            ),
            const Spacer(),
            Text(
              'Fall Asleep Fast',
              style: AppText.bold400(context).copyWith(
                color: AppColors.lightVersion,
                fontSize: 16.sp,
              ),
            ),
            Text(
              '15 Minutes',
              style: AppText.bold400(context).copyWith(
                color: AppColors.lightVersion,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TagButton extends StatelessWidget {
  const _TagButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        'data',
        style: AppText.bold300(context).copyWith(
          fontSize: 14.sp,
          color: AppColors.primary,
        ),
      ),
    );
  }
}