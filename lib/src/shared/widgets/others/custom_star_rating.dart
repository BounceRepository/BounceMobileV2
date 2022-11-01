import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomStarRating extends StatelessWidget {
  const CustomStarRating({Key? key, this.size, required this.rating}) : super(key: key);

  final double rating;
  final double? size;

  @override
  Widget build(BuildContext context) {
    const color = AppColors.primary;

    return RatingBar(
      initialRating: rating,
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
