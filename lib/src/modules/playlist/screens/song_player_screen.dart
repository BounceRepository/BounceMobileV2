import 'dart:developer';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:bounce_patient_app/src/modules/playlist/controllers/audio_player_controller.dart';
import 'package:bounce_patient_app/src/modules/playlist/controllers/song_list_controller.dart';
import 'package:bounce_patient_app/src/modules/playlist/models/audio_position_data.dart';
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
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  void init() async {
    final songs = context.read<SongListController>().songs;

    if (songs.isNotEmpty) {
      final controller = context.read<AudioPlayerController>();

      try {
        await controller.init(songList: songs);
      } on Failure catch (e) {
        controller.setFailure(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                const _SongDetailsView(),
                const Spacer(),
                const _PlayTrackSection(),
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

class _SongDetailsView extends StatelessWidget {
  const _SongDetailsView();

  @override
  Widget build(BuildContext context) {
    final player = context.watch<AudioPlayerController>().player;

    return StreamBuilder<SequenceState?>(
      stream: player.sequenceStateStream,
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state?.sequence.isEmpty ?? true) {
          return const SizedBox.shrink();
        }

        final song = state!.currentSource!.tag as MediaItem;
        return Column(
          children: [
            Hero(
              tag: song.title,
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
                    image: song.artUri.toString(),
                    size: 252.h,
                  ),
                ),
              ),
            ),
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
              song.artist != null ? song.artist!.toTitleCase : '',
              textAlign: TextAlign.center,
              style: AppText.bold500(context).copyWith(
                fontSize: 12.sp,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PlayTrackSection extends StatefulWidget {
  const _PlayTrackSection();

  @override
  State<_PlayTrackSection> createState() => _PlayTrackSectionState();
}

class _PlayTrackSectionState extends State<_PlayTrackSection> {
  void seek(Duration duration) async {
    final controller = context.read<AudioPlayerController>();
    try {
      await controller.seek(duration);
    } on Failure catch (e) {
      log('${e.message} ===> seeking duration');
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AudioPlayerController>();
    final audioPositionDataStream = controller.positionDataStream;

    return StreamBuilder<AudioPositionData>(
      stream: audioPositionDataStream,
      builder: (context, snapshot) {
        final postionData = snapshot.data;
        return ProgressBar(
          progress: postionData?.position ?? Duration.zero,
          buffered: postionData?.bufferPosition ?? Duration.zero,
          total: postionData?.duration ?? Duration.zero,
          onSeek: (duration) => seek(duration),
        );
      },
    );
  }
}

class _PlayerControlsSection extends StatefulWidget {
  const _PlayerControlsSection();

  @override
  State<_PlayerControlsSection> createState() => _PlayerControlsSectionState();
}

class _PlayerControlsSectionState extends State<_PlayerControlsSection> {
  void play() async {
    final controller = context.read<AudioPlayerController>();

    try {
      await controller.play();
    } on Failure catch (e) {
      Messenger.error(message: e.message);
    }
  }

  void pause() async {
    final controller = context.read<AudioPlayerController>();

    try {
      await controller.pause();
    } on Failure catch (e) {
      Messenger.error(message: e.message);
    }
  }

  void seekToPrevious() async {
    final controller = context.read<AudioPlayerController>();

    try {
      await controller.seekToPrevious();
    } on Failure catch (e) {
      Messenger.error(message: e.message);
    }
  }

  void seekToNext() async {
    final controller = context.read<AudioPlayerController>();

    try {
      await controller.seekToPrevious();
    } on Failure catch (e) {
      Messenger.error(message: e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AudioPlayerController>();
    final player = controller.player;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        button(
          //icon: MusicIcons.previous,
          icon: Icons.skip_previous_outlined,
          size: 50.h,
          iconSize: 35.h,
          onTap: seekToPrevious,
        ),
        SizedBox(width: 20.w),
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final isPlaying = playerState?.playing;

            if (!(isPlaying ?? false)) {
              return button(
                icon: Icons.play_arrow,
                size: 72.h,
                iconSize: 60.h,
                showShadow: true,
                onTap: play,
              );
            } else if (processingState != ProcessingState.completed) {
              return button(
                icon: Icons.pause,
                size: 72.h,
                iconSize: 60.h,
                showShadow: true,
                onTap: pause,
              );
            }

            return button(
              icon: Icons.play_arrow,
              size: 72.h,
              iconSize: 60.h,
              showShadow: true,
              onTap: () {},
            );
          },
        ),
        SizedBox(width: 20.w),
        button(
          //icon: MusicIcons.next,
          icon: Icons.skip_next_outlined,
          size: 50.h,
          iconSize: 35.h,
          onTap: seekToNext,
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
