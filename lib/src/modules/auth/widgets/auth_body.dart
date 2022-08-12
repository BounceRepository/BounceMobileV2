import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_child_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthBody extends StatelessWidget {
  const AuthBody({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              AuthIcons.circles,
              height: 156.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 23.w),
              child: Column(
                children: children,
              ),
            ),
          ],
        ),
      ),
    );
  }
}