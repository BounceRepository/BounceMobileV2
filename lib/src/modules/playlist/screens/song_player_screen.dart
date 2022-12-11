import 'package:bounce_patient_app/src/modules/playlist/controllers/audio_player_controller.dart';
import 'package:bounce_patient_app/src/modules/playlist/models/song.dart';
import 'package:bounce_patient_app/src/shared/extensions/string.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/messenger.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/default_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SongPlayerScreen extends StatefulWidget {
  const SongPlayerScreen({super.key});

  @override
  State<SongPlayerScreen> createState() => _SongPlayerScreenState();
}

class _SongPlayerScreenState extends State<SongPlayerScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      init();
      context.read<AudioPlayerController>().onStateChanged();
    });
  }

  void init() async {
    final controller = context.read<AudioPlayerController>();
    final song = context.read<AudioPlayerController>().currentPlayingSong;

    try {
      await controller.loadSong(song);
    } on Failure catch (e) {
      Messenger.error(message: e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final song = context.watch<AudioPlayerController>().currentPlayingSong;
    final artist = song.artist;

    return Scaffold(
      appBar: const CustomAppBar(
        backgroundColor: Colors.transparent,
        label: 'Happy',
      ),
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Padding(
            padding: AppPadding.symetricHorizontalOnly,
            child: Column(
              children: [
                SizedBox(height: 28.h),
                SizedBox(
                  width: 292.w,
                  child: Text(
                    '“Happiness is a journey not a destination, enjoy it.”',
                    textAlign: TextAlign.center,
                    style: AppText.bold300(context).copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                _ImageFrame(song),
                SizedBox(height: 20.h),
                Text(
                  song.title.toTitleCase,
                  textAlign: TextAlign.center,
                  style: AppText.bold500(context).copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  artist.fullName.toTitleCase,
                  textAlign: TextAlign.center,
                  style: AppText.bold500(context).copyWith(
                    fontSize: 12.sp,
                  ),
                ),
                const Spacer(),
                _PlayTrackSection(song),
                const Spacer(),
                const _PlayerControlsSection(),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ImageFrame extends StatelessWidget {
  const _ImageFrame(this.song);

  final Song song;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: song.tag,
      child: Container(
        width: 292.w,
        height: 292.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.secondary,
          boxShadow: AppColors.boxshadow4,
        ),
        child: Container(
          width: 252.h,
          height: 252.h,
          margin: EdgeInsets.all(20.sp),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
          ),
          child: CustomCacheNetworkImage(
            image: song.image,
            size: 252.h,
          ),
        ),
      ),
    );
  }
}

class _PlayTrackSection extends StatelessWidget {
  const _PlayTrackSection(this.song);

  final Song song;

  void seek({
    required BuildContext context,
    required double value,
  }) async {
    final controller = context.read<AudioPlayerController>();

    try {
      await controller.seek(value.toInt());
    } on Failure catch (e) {
      Messenger.error(message: e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AudioPlayerController>();
    final postion = controller.position;

    return Row(
      children: [
        time(context, formatTime(postion)),
        trackSlider(
          duration: song.duration,
          postion: postion,
          onChanged: (value) => seek(context: context, value: value),
        ),
        time(context, formatTime(song.duration - postion)),
      ],
    );
  }

  Widget time(BuildContext context, String t) {
    return Text(
      t,
      style: AppText.bold500(context).copyWith(
        fontSize: 10.sp,
      ),
    );
  }

  Widget trackSlider(
      {required Duration duration,
      required Duration postion,
      required Function(double) onChanged}) {
    return Expanded(
      child: Slider(
        min: 0,
        max: duration.inSeconds.toDouble(),
        value: postion.inSeconds.toDouble(),
        activeColor: AppColors.primary,
        inactiveColor: AppColors.grey,
        onChanged: onChanged,
      ),
    );
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }
}

class _PlayerControlsSection extends StatelessWidget {
  const _PlayerControlsSection();

  void play(BuildContext context) async {
    final controller = context.read<AudioPlayerController>();

    try {
      await controller.play();
    } on Failure catch (e) {
      Messenger.error(message: e.message);
    }
  }

  void playPrev(BuildContext context) async {
    final controller = context.read<AudioPlayerController>();

    try {
      await controller.playPrev();
    } on Failure catch (e) {
      Messenger.error(message: e.message);
    }
  }

  void playNext(BuildContext context) async {
    final controller = context.read<AudioPlayerController>();

    try {
      await controller.playNext();
    } on Failure catch (e) {
      Messenger.error(message: e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AudioPlayerController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        button(
          //icon: MusicIcons.previous,
          icon: Icons.skip_previous_outlined,
          size: 50.h,
          iconSize: 35.h,
          onTap: () => playPrev(context),
        ),
        SizedBox(width: 20.w),
        button(
          //icon: MusicIcons.play,
          icon: controller.isPlaying ? Icons.pause : Icons.play_arrow_outlined,
          size: 72.h,
          iconSize: 60.h,
          showShadow: true,
          onTap: () => play(context),
        ),
        SizedBox(width: 20.w),
        button(
          //icon: MusicIcons.next,
          icon: Icons.skip_next_outlined,
          size: 50.h,
          iconSize: 35.h,
          onTap: () => playNext(context),
        ),
      ],
    );
  }

  Widget button({
    required IconData icon,
    required double iconSize,
    required double size,
    bool showShadow = false,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: showShadow ? AppColors.boxshadow4 : null,
        ),
        child: Icon(
          icon,
          // height: iconSize,
          // width: iconSize,
          // fit: BoxFit.cover,
          color: AppColors.lightText,
          size: iconSize,
        ),
      ),
    );
  }
}
