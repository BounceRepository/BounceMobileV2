import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppImageView extends StatelessWidget {
  const AppImageView(this.image, {Key? key, this.size}) : super(key: key);

  final String image;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? 68.h,
      width: size ?? 68.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class CustomCacheNetworkImage extends StatelessWidget {
  const CustomCacheNetworkImage({
    Key? key,
    required this.image,
    this.size,
    this.height,
    this.width,
    this.borderRadius,
    this.isCirclular = true,
    this.loadingColor,
  }) : super(key: key);

  final String image;
  final double? size;
  final double? height;
  final double? width;
  final bool isCirclular;
  final BorderRadiusGeometry? borderRadius;
  final Color? loadingColor;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, imageProvider) => Container(
        width: width ?? size ?? 68.h,
        height: height ?? size ?? 68.h,
        decoration: BoxDecoration(
          shape: isCirclular ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: borderRadius,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
          border: Border.all(color: AppColors.primary.withOpacity(.5)),
        ),
      ),
      width: width ?? size ?? 68.h,
      height: height ?? size ?? 68.h,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, progress) => Container(
        width: size ?? 68.h,
        height: size ?? 68.h,
        decoration: BoxDecoration(
          shape: isCirclular ? BoxShape.circle : BoxShape.rectangle,
          border:
              isCirclular ? Border.all(color: AppColors.primary.withOpacity(.5)) : null,
        ),
        child: CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation<Color>(
                loadingColor ?? AppColors.primary.withOpacity(.5))),
      ),
      errorWidget: (context, url, error) => Container(
        width: size ?? 68.h,
        height: size ?? 68.h,
        decoration: BoxDecoration(
          shape: isCirclular ? BoxShape.circle : BoxShape.rectangle,
          border:
              isCirclular ? Border.all(color: AppColors.primary.withOpacity(.5)) : null,
        ),
        child: const Icon(Icons.error_outline),
      ),
    );
  }
}

class DefaultAppImage extends StatelessWidget {
  const DefaultAppImage({
    Key? key,
    this.size,
  }) : super(key: key);

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? 68.h,
      width: size ?? 68.h,
      decoration: const BoxDecoration(
        color: AppColors.grey3,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.person,
        size: size != null ? size! * 0.7 : 40.sp,
        color: const Color(0xffC5B8B8),
      ),
    );
  }
}
