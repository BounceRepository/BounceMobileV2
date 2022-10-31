import 'package:bounce_patient_app/src/modules/playlist/screens/player_screen.dart';
import 'package:bounce_patient_app/src/modules/playlist/widgets/play_button.dart';
import 'package:bounce_patient_app/src/shared/assets/images.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MusicTile extends StatelessWidget {
  const MusicTile({
    super.key,
    this.smallMargin = false,
    this.bottomPadding = false,
    this.height,
  });

  final double? height;
  final bool smallMargin;
  final bool bottomPadding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: GestureDetector(
        onTap: () {
          AppNavigator.to(context, const PlayerScreen());
        },
        child: Padding(
          padding: EdgeInsets.only(
            right: smallMargin ? 8.w : 0,
            bottom: bottomPadding ? 36.h : 0,
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CachedNetworkImage(
                  imageUrl: AppImages.playlistAlbum,
                  height: height ?? 170.h,
                  width: 344.w,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  progressIndicatorBuilder: (context, url, downloadProgress) => Container(
                    height: height ?? 170.h,
                    width: 344.w,
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
              Container(
                height: height ?? 170.h,
                width: 240.w,
                padding: EdgeInsets.only(top: 12.h, left: 17.w, right: 12.w, bottom: 8.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromRGBO(0, 0, 0, 0.92).withOpacity(0.8333),
                      const Color.fromRGBO(0, 0, 0, 0.92).withOpacity(0.783),
                      const Color.fromRGBO(0, 0, 0, 0.92).withOpacity(1),
                      const Color.fromRGBO(0, 0, 0, 0.7176).withOpacity(0.5),
                      const Color.fromRGBO(0, 0, 0, 0.0736).withOpacity(0.1458),
                      const Color.fromRGBO(0, 0, 0, 0).withOpacity(0),
                    ],
                    begin: const Alignment(-1.0, 0.5),
                    end: const Alignment(0.5, 1.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Happy Day',
                      style: AppText.bold400(context).copyWith(
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'By Willam Wesley',
                      style: AppText.bold300(context).copyWith(
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    const _Tag(),
                    SizedBox(height: 4.h),
                  ],
                ),
              ),
              Positioned(
                right: 12.w,
                bottom: 8.h,
                child: const PlayButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.grey3,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Text(
        'Daily Routine',
        style: AppText.bold500(context).copyWith(
          fontSize: 12.sp,
          color: Colors.white,
        ),
      ),
    );
  }
}
