import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialAuthView extends StatelessWidget {
  const SocialAuthView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 80.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _SocialIconButton(
            icon: SocialIcons.google,
            onTap: () {},
          ),
          _SocialIconButton(
            icon: SocialIcons.apple,
            onTap: () {},
          ),
          _SocialIconButton(
            icon: SocialIcons.facebook,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _SocialIconButton extends StatelessWidget {
  const _SocialIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final String icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SvgPicture.asset(
        icon,
        height: 20.h,
        width: 20.h,
      ),
    );
  }
}
