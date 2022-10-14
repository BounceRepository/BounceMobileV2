import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomStarRating extends StatelessWidget {
  const CustomStarRating({Key? key, this.size}) : super(key: key);

  final double? size;

  @override
  Widget build(BuildContext context) {
    const color = Color(0xffFDD835);

    return RatingBar(
      initialRating: 4.5,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemSize: size ?? 20.sp,
      itemCount: 5,
      ratingWidget: RatingWidget(
        full: const Icon(Icons.star, color: color),
        half: const Icon(Icons.star_half, color: color),
        empty: const Icon(Icons.star_border, color: color),
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}
