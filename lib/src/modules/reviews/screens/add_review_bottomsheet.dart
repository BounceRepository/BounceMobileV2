import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/reviews/controllers/review_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/messenger.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/input/custom_textfield.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_star_rating.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/default_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

Future<dynamic> showAddReviewBottomsheet({
  required BuildContext context,
  required Therapist therapist,
}) {
  return showCustomBottomSheet(
    context,
    isDismissible: false,
    enableDrag: false,
    body: _Body(therapist: therapist),
  );
}

class _Body extends StatefulWidget {
  const _Body({required this.therapist});

  final Therapist therapist;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController commentController;
  double rating = 0.0;

  @override
  void initState() {
    super.initState();
    commentController = TextEditingController();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  void submit() async {
    if (_formKey.currentState!.validate()) {
      if (rating == 0.0) {
        Messenger.error(message: 'Please tap the star to rate your experience');
        return;
      }

      final controller = context.read<ReviewController>();

      try {
        await controller.create(
          therapistId: widget.therapist.id,
          rating: rating,
          comment: commentController.text,
          createdAt: DateTime.now().toLocal(),
        );
        Navigator.pop(context);
        //AppNavigator.removeAllUntil(context, const DashboardView());
        Messenger.success(message: 'Review submitted');
      } on Failure catch (e) {
        Messenger.error(message: e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final therapist = widget.therapist;
    final doctor = '${therapist.title}. ${therapist.firstName}';

    return Form(
      key: _formKey,
      child: CustomBottomSheetBody(
        body: [
          const BottomSheetTitle('Review'),
          SizedBox(height: 44.h),
          CustomCacheNetworkImage(image: therapist.profilePicture, size: 100.h),
          SizedBox(height: 19.h),
          Text(
            doctor,
            textAlign: TextAlign.center,
            style: AppText.bold700(context).copyWith(
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 9.h),
          Text(
            'Rate the consultation with your therapist',
            textAlign: TextAlign.center,
            style: AppText.bold400(context).copyWith(
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 33.87.h),
          CustomStarRating(
            rating: rating,
            size: 35.sp,
            isNotSelectable: false,
            onRatingUpdate: (value) {
              rating = value;
              setState(() {});
            },
          ),
          SizedBox(height: 41.56.h),
          CustomTextField(
            controller: commentController,
            maxLines: 5,
            hintText: 'Share your experience...',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please share your experience';
              }
              return null;
            },
          ),
          SizedBox(height: 22.h),
          Consumer<ReviewController>(
            builder: (context, controller, _) {
              return AppButton(
                label: 'Submit',
                isLoading: controller.isLoading,
                onTap: submit,
              );
            },
          ),
        ],
      ),
    );
  }
}
