import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/book_session/screens/screens.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_star_rating.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/default_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TherapistListItem extends StatelessWidget {
  const TherapistListItem(this.therapist, {Key? key}) : super(key: key);

  final Therapist therapist;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppNavigator.to(context, TherapistDetailScreen(therapist));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 32.h),
        padding: EdgeInsets.symmetric(vertical: 15.4.h, horizontal: 14.75.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: const Color(0xffFEF3E7),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DefaultAppImage(),
            //CircularNetworkImage(image: therapist.profilePicture),
            SizedBox(width: 17.13.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${therapist.fullName}, ${therapist.certifications.first.toUpperCase()}',
                    style: AppText.bold800(context).copyWith(
                      fontSize: 16.sp,
                      color: AppColors.textBrown,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    '${therapist.specializationList} • ${therapist.experience} Years Experience',
                    style: AppText.bold400(context).copyWith(
                      fontSize: 12.sp,
                      color: AppColors.textBrown,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      CustomStarRating(rating: therapist.rating),
                      SizedBox(width: 8.w),
                      Text(
                        '${therapist.reviews} Reviews',
                        style: AppText.bold500(context).copyWith(
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
