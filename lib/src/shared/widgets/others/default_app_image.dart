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
    this.isCirclular = true,
  }) : super(key: key);

  final String image;
  final double? size;
  final bool isCirclular;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, imageProvider) => Container(
        width: size ?? 68.h,
        height: size ?? 68.h,
        decoration: BoxDecoration(
          shape: isCirclular ? BoxShape.circle : BoxShape.rectangle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      width: size ?? 68.h,
      height: size ?? 68.h,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => const Icon(Icons.error),
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
