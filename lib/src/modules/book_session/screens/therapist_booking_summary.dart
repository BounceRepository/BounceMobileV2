import 'package:bounce_patient_app/src/modules/book_session/controllers/book_session_controller.dart';
import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/book_session/screens/screens.dart';
import 'package:bounce_patient_app/src/modules/book_session/widgets/amount_per_hour_view.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_child_scrollview.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_star_rating.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/default_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TherapistBookingSummary extends StatefulWidget {
  const TherapistBookingSummary({Key? key, required this.therapist}) : super(key: key);

  final Therapist therapist;

  @override
  State<TherapistBookingSummary> createState() => _TherapistBookingSummaryState();
}

class _TherapistBookingSummaryState extends State<TherapistBookingSummary> {
  @override
  void initState() {
    super.initState();
    context.read<BookSessionController>().init();
  }

  @override
  Widget build(BuildContext context) {
    final doctorName = '${widget.therapist.title} ${widget.therapist.firstName}';

    return Scaffold(
      appBar: const CustomAppBar(label: 'Book Session'),
      body: SafeArea(
        child: Center(
          child: CustomChildScrollView(
            child: Column(
              children: [
                CustomCacheNetworkImage(
                  image: widget.therapist.profilePicture,
                  size: 100.h,
                ),
                SizedBox(height: 19.h),
                Text(
                  doctorName,
                  textAlign: TextAlign.center,
                  style: AppText.bold700(context).copyWith(
                    fontSize: 18.sp,
                    color: AppColors.textBrown,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  widget.therapist.specializationList,
                  textAlign: TextAlign.center,
                  style: AppText.bold400(context).copyWith(
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomStarRating(rating: widget.therapist.rating),
                    SizedBox(width: 8.w),
                    Text(
                      '${widget.therapist.reviewCount} Reviews',
                      style: AppText.bold500(context).copyWith(
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 48.h),
                SizedBox(
                  width: 264.w,
                  child: Text(
                    'You will get instant service from $doctorName',
                    textAlign: TextAlign.center,
                    style: AppText.bold400(context).copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Service charge:',
                      style: AppText.bold400(context).copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    AmountPerHourView(amount: widget.therapist.serviceChargePerHour),
                  ],
                ),
                SizedBox(height: 72.h),
                AppButton(
                  label: 'Book Now',
                  onTap: () {
                    AppNavigator.to(
                        context, BookSessionScreen(therapist: widget.therapist));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
