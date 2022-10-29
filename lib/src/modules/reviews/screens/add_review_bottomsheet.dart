import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/input/custom_textfield.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_star_rating.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/default_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> showAddReviewBottomsheet({
  required BuildContext context,
}) {
  return showCustomBottomSheet(
    context,
    isDismissible: false,
    enableDrag: false,
    body: const _Body(),
  );
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetBody(
      body: [
        const BottomSheetTitle('Review'),
        SizedBox(height: 44.h),
        DefaultAppImage(size: 100.h),
        SizedBox(height: 19.h),
        Text(
          'Dr Bellamy',
          textAlign: TextAlign.center,
          style: AppText.bold700(context).copyWith(
            fontSize: 18.sp,
          ),
        ),
        SizedBox(height: 9.h),
        Text(
          'Rate the consultation with your therapist',
          textAlign: TextAlign.center,
          style: AppText.bold700(context).copyWith(
            fontSize: 18.sp,
          ),
        ),
        SizedBox(height: 33.87.h),
        CustomStarRating(rating: 0, size: 25.sp),
        SizedBox(height: 41.56.h),
        CustomTextField(
          controller: textController,
          maxLines: 5,
          hintText: 'Share your experience...',
        ),
        SizedBox(height: 22.h),
        AppButton(
          label: 'Submit',
          onTap: () {},
        ),
      ],
    );
  }
}
