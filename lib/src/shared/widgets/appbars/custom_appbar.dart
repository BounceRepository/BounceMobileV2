import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.centerTitle = true,
    this.automaticallyImplyLeading = true,
    this.removeActionsPadding = false,
    this.title,
    this.label,
    this.iconTheme,
  }) : super(key: key);

  final Widget? leading;
  final Widget? title;
  final String? label;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final bool centerTitle;
  final bool automaticallyImplyLeading;
  final bool removeActionsPadding;
  final IconThemeData? iconTheme;

  @override
  Size get preferredSize => Size.fromHeight(50.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: leading,
      centerTitle: centerTitle,
      iconTheme: iconTheme,
      title: title != null
          ? title!
          : label != null
              ? Text(
                  label!,
                  style: AppText.bold700(context).copyWith(
                    fontSize: 17.sp,
                  ),
                )
              : const SizedBox.shrink(),
      actions: [
        actions != null
            ? Padding(
                padding: removeActionsPadding
                    ? EdgeInsets.zero
                    : EdgeInsets.only(right: AppPadding.horizontal),
                child: Row(children: actions!),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBarIcon(
      Icons.arrow_back,
      onTap: () {
        Navigator.maybePop(context);
      },
    );
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({Key? key, required this.onTap}) : super(key: key);

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return AppBarIcon(
      Icons.search,
      onTap: onTap,
      size: 37.w,
    );
  }
}

class AppBarIcon extends StatelessWidget {
  const AppBarIcon(
    this.icon, {
    Key? key,
    required this.onTap,
    this.size,
  }) : super(key: key);

  final IconData icon;
  final Function() onTap;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return _AppBarIconContainer(
      onTap: onTap,
      size: size,
      child: Icon(
        icon,
        size: 20.sp,
        color: const Color(0xff292D32),
      ),
    );
  }
}

class AppBarSvgIcon extends StatelessWidget {
  const AppBarSvgIcon(
    this.icon, {
    Key? key,
    required this.onTap,
    this.size,
  }) : super(key: key);

  final String icon;
  final Function() onTap;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return _AppBarIconContainer(
      onTap: onTap,
      size: size,
      child: SvgPicture.asset(
        icon,
        height: 20.h,
        width: 20.h,
        fit: BoxFit.fill,
      ),
    );
  }
}

class _AppBarIconContainer extends StatelessWidget {
  const _AppBarIconContainer({
    Key? key,
    required this.onTap,
    this.size,
    required this.child,
  }) : super(key: key);

  final Function() onTap;
  final double? size;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size ?? 32.h,
        width: size ?? 32.h,
        margin: EdgeInsets.symmetric(
          vertical: 7.h,
          horizontal: AppPadding.horizontal,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.r),
          color: const Color(0xffF9F6F4),
        ),
        child: child,
      ),
    );
  }
}
