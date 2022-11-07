import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miniplayer/miniplayer.dart';

class MiniPlayerView extends StatelessWidget {
  const MiniPlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Miniplayer(
      minHeight: 70.h,
      maxHeight: 352.h,
      builder: (height, percentage) => Container(
        height: height,
        color: Colors.red,
      ),
    );
  }
}
