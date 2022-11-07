import 'dart:ui';

import 'package:bounce_patient_app/src/modules/playlist/controllers/audio_player_controller.dart';
import 'package:bounce_patient_app/src/modules/playlist/models/song.dart';
import 'package:bounce_patient_app/src/modules/playlist/screens/song_player_screen.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({super.key, required this.song});

  final Song song;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<AudioPlayerController>().updateSong(song);
        AppNavigator.to(context, const SongPlayerScreen());
      },
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
          child: Container(
            height: 48.h,
            width: 48.h,
            padding: EdgeInsets.all(10.sp),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.2),
            ),
            child: SvgPicture.asset(
              MusicIcons.play,
              color: Colors.white,
              height: 24.h,
              width: 24.h,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
