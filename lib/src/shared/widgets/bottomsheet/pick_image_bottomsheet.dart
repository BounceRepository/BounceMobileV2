import 'package:bounce_patient_app/src/shared/image/controller/image_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/messenger.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

Future<dynamic> pickImageBottomSheet({required BuildContext context}) {
  return showCustomBottomSheet(
    context,
    body: const _Body(),
  );
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  void openCamera() async {
    final controller = context.read<ImageController>();

    try {
      final image = await controller.pickImageFromCamera();
      if (image != null) {
        if (!mounted) return;
        Navigator.pop(context, image);
      }
    } on Failure {
      Messenger.error(message: 'Failed to pick image');
    }
  }

  void openGallery() async {
    final controller = context.read<ImageController>();

    try {
      final image = await controller.pickImageFromGallery();
      if (image != null) {
        if (!mounted) return;
        Navigator.pop(context, image);
      }
    } on Failure {
      Messenger.error(message: 'Failed to pick image from gallery');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetBody(
      body: [
        const BottomSheetDragger(),
        SizedBox(height: 40.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Button(
              icon: Icons.camera_alt,
              label: 'Camera',
              onTap: openCamera,
            ),
            SizedBox(width: 20.w),
            _Button(
              icon: Icons.image,
              label: 'Gallery',
              onTap: openGallery,
            ),
          ],
        ),
        SizedBox(height: 40.h),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(5.r),
        child: Container(
          padding: EdgeInsets.all(10.sp),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey, width: 2),
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: AppColors.primary,
                size: 40.sp,
              ),
              SizedBox(height: 10.h),
              Text(
                label,
                style: AppText.bold500(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
