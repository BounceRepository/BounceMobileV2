import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';

class CustomLogoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomLogoAppBar({
    Key? key,
    this.leading,
    this.actions,
    this.logoColor,
    this.showGradientBackground = true,
    this.automaticallyImplyLeading = true,
    this.title,
    this.label,
  }) : super(key: key);

  final Color? logoColor;
  final Widget? leading;
  final Widget? title;
  final String? label;
  final List<Widget>? actions;
  final bool showGradientBackground;
  final bool automaticallyImplyLeading;

  @override
  Size get preferredSize => Size.fromHeight(50.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: automaticallyImplyLeading,
      elevation: 0,
      leading: leading,
      title: title ??
          Text(
            label!,
            style: AppText.bold700(context).copyWith(
              fontSize: 17.sp,
            ),
          ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: AppPadding.horizontal),
          child: Row(children: actions == null ? [] : actions!),
        ),
      ],
    );
  }
}
