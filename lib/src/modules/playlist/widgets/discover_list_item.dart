import 'package:bounce_patient_app/src/modules/playlist/screens/player_screen.dart';
import 'package:bounce_patient_app/src/modules/playlist/widgets/play_button.dart';
import 'package:bounce_patient_app/src/shared/assets/images.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscoverListItem extends StatelessWidget {
  const DiscoverListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.to(context, const PlayerScreen());
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 36.h),
        child: SizedBox(
          width: 344.w,
          height: 176.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CachedNetworkImage(
                  imageUrl: AppImages.playlistAlbum,
                  width: 344.w,
                  height: 176.h,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  progressIndicatorBuilder: (context, url, downloadProgress) => Container(
                    width: 344.w,
                    height: 176.h,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      'Loading....',
                      style: AppText.bold400(context).copyWith(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8.h,
                left: 8.w,
                bottom: 8.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _TagButton(),
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
              const Positioned(child: PlayButton()),
            ],
          ),
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
