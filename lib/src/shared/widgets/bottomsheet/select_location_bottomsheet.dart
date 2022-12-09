import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> showLocationBottomsheet({
  required BuildContext context,
  required String selectedOption,
  required List<String> options,
}) {
  return showCustomBottomSheet(
    context,
    body: _LocationListBody(
      selectedOption: selectedOption,
      options: options,
    ),
  );
}

class _LocationListBody extends StatelessWidget {
  const _LocationListBody({
    required this.selectedOption,
    required this.options,
  });

  final String selectedOption;
  final List<String> options;

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetBody(
      height: 400.h,
      padding: EdgeInsets.only(
        top: 20.h,
        left: AppPadding.horizontal,
        right: AppPadding.horizontal,
      ),
      body: [
        const BottomSheetDragger(),
        SizedBox(height: 30.h),
        SizedBox(
          height: 340.h,
          child: OptionListView(
            options: options,
            selectedOption: selectedOption,
          ),
        ),
      ],
    );
  }
}

class OptionListView extends StatelessWidget {
  const OptionListView({
    Key? key,
    required this.options,
    required this.selectedOption,
    this.onItemSelected,
  }) : super(key: key);

  final List<String> options;
  final String selectedOption;
  final Function(String value)? onItemSelected;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: List.generate(options.length, (index) {
          final title = options[index];

          return _LocationOptionTile(
            isSelected: title == selectedOption,
            title: title,
          );
        }),
      ),
    );
  }
}

class _LocationOptionTile extends StatelessWidget {
  const _LocationOptionTile({
    required this.isSelected,
    required this.title,
  });

  final bool isSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context, title);
      },
      child: SelectableOptionTile(
        title: title,
        isSelected: isSelected,
      ),
    );
  }
}

class SelectableOptionTile extends StatelessWidget {
  const SelectableOptionTile({
    super.key,
    required this.isSelected,
    required this.title,
    this.onChanged,
  });

  final bool isSelected;
  final String title;
  final Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 32.h),
      child: Row(
        children: [
          CustomCheckBox(
            value: isSelected,
            onChanged: onChanged ?? (value) {},
          ),
          SizedBox(width: 26.w),
          Text(
            title,
            style: AppText.titleStyle(context),
          ),
        ],
      ),
    );
  }
}
