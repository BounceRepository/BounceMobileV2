import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/input/custom_textfield.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/default_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddFeedScreen extends StatefulWidget {
  const AddFeedScreen({super.key});

  @override
  State<AddFeedScreen> createState() => _AddFeedScreenState();
}

class _AddFeedScreenState extends State<AddFeedScreen> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void send() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _ChooseGroupSection(),
              SizedBox(height: 20.h),
              CustomTextField(
                controller: _textEditingController,
                hintText: 'What is wrong?',
                filled: false,
                textInputType: TextInputType.multiline,
                maxLines: null,
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: AppPadding.horizontal, vertical: 14.h),
          child: Row(
            children: [
              DefaultAppImage(size: 48.h),
              SizedBox(width: 12.w),
              Expanded(
                child: AppButton(
                  label: 'Send',
                  onTap: send,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChooseGroupSection extends StatefulWidget {
  const _ChooseGroupSection();

  @override
  State<_ChooseGroupSection> createState() => _ChooseGroupSectionState();
}

class _ChooseGroupSectionState extends State<_ChooseGroupSection> {
  String label = 'Choose Group';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final result =
            await _chooseGroupBottomsheet(context: context, selectedGroup: label);

        if (result != null) {
          label = result as String;
          setState(() {});
        }
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: 135.w,
        margin: EdgeInsets.only(left: AppPadding.horizontal),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: AppText.bold500(context).copyWith(
                  fontSize: 12.sp,
                  color: AppColors.primary,
                ),
              ),
            ),
            SizedBox(width: 5.w),
            Icon(
              Icons.keyboard_arrow_down_outlined,
              color: AppColors.primary,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}

Future<dynamic> _chooseGroupBottomsheet({
  required BuildContext context,
  required String selectedGroup,
}) {
  return showCustomBottomSheet(context,
      body: _ChooseGroupView(selectedGroup: selectedGroup));
}

class _ChooseGroupView extends StatefulWidget {
  const _ChooseGroupView({required this.selectedGroup});

  final String selectedGroup;

  @override
  State<_ChooseGroupView> createState() => _ChooseGroupViewState();
}

class _ChooseGroupViewState extends State<_ChooseGroupView> {
  final groups = [
    'Relationship',
    'Self Care',
    'Work Ethics',
    'Family',
    'Sexuality',
    'Parenting',
  ];
  String? selectedGroup;

  @override
  void initState() {
    super.initState();
    selectedGroup = widget.selectedGroup;
  }

  void select(String group) {
    selectedGroup = group;
    Navigator.pop(context, selectedGroup);
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetBody(
      body: [
        const BottomSheetDragger(),
        SizedBox(height: 5.h),
        const BottomSheetTitle('Choose Group'),
        SizedBox(height: 30.h),
        Column(
          children: List.generate(
              groups.length,
              (index) => tile(
                    label: groups[index],
                    isSelected: selectedGroup == groups[index],
                    onTap: () => select(groups[index]),
                  )),
        ),
        SizedBox(height: 50.h),
      ],
    );
  }

  Widget tile({
    required String label,
    required bool isSelected,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: AppColors.primary,
              size: 20.sp,
            ),
            SizedBox(width: 26.4.w),
            Text(
              label,
              style: AppText.bold300(context).copyWith(
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}