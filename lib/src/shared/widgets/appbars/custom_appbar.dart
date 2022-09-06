import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CustomLogoAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const CustomLogoAppBar({
//     Key? key,
//     this.leading,
//     this.actions,
//     this.logoColor,
//     this.showGradientBackground = true,
//     this.automaticallyImplyLeading = true,
//     this.title,
//     this.label,
//   }) : super(key: key);

//   final Color? logoColor;
//   final Widget? leading;
//   final Widget? title;
//   final String? label;
//   final List<Widget>? actions;
//   final bool showGradientBackground;
//   final bool automaticallyImplyLeading;

//   @override
//   Size get preferredSize => Size.fromHeight(50.h);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       centerTitle: true,
//       backgroundColor: Colors.white,
//       automaticallyImplyLeading: automaticallyImplyLeading,
//       elevation: 0,
//       leading: leading,
//       title: title ??
//           Text(
//             label!,
//             style: AppText.bold700(context).copyWith(
//               fontSize: 17.sp,
//             ),
//           ),
//       actions: [
//         Padding(
//           padding: EdgeInsets.only(right: AppPadding.horizontal),
//           child: Row(children: actions == null ? [] : actions!),
//         ),
//       ],
//     );
//   }
// }

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 25.h, bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            size: 32.sp,
          ),
          Icon(
            Icons.notifications_outlined,
            size: 32.sp,
          )
        ],
      ),
    );
  }
}
