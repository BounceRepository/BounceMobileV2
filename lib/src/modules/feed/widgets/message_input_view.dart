import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/widgets/input/custom_textfield.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/default_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final _borderRadius = BorderRadius.only(
  topLeft: Radius.circular(40.r),
  topRight: Radius.circular(40.r),
);

final _decoration = BoxDecoration(
  color: Colors.white,
  boxShadow: AppColors.boxshadow4,
  borderRadius: _borderRadius,
);

class FeedMessageInputView extends StatefulWidget {
  const FeedMessageInputView({super.key});

  @override
  State<FeedMessageInputView> createState() => _FeedMessageInputViewState();
}

class _FeedMessageInputViewState extends State<FeedMessageInputView> {
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
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: _decoration.copyWith(
        borderRadius: BorderRadius.zero,
      ),
      child: Row(
        children: [
          Padding(
            padding: AppPadding.symetricHorizontalOnly,
            child: DefaultAppImage(size: 48.h),
          ),
          Expanded(
            child: CustomTextField(
              controller: textController,
              hintText: 'Type message',
              suffixIcon: TextFieldIcon(
                icon: Icons.send,
                color: AppColors.lightText,
                onTap: () {
                  textController.clear();
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}