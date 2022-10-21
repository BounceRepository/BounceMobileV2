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
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}
