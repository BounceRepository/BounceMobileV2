import 'package:bounce_patient_app/src/modules/playlist/controllers/audio_player_controller.dart';
import 'package:bounce_patient_app/src/modules/playlist/controllers/song_list_controller.dart';
import 'package:bounce_patient_app/src/modules/playlist/screens/playlist_list_screen.dart';
import 'package:bounce_patient_app/src/modules/playlist/widgets/music_list_tile.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_loading_indicator.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AllSongsView extends StatefulWidget {
  const AllSongsView({
    Key? key,
  }) : super(key: key);

  @override
  State<AllSongsView> createState() => _AllSongsViewState();
}

class _AllSongsViewState extends State<AllSongsView> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllSongs();
    });
  }

  void getAllSongs() async {
    final controller = context.read<SongListController>();

    if (controller.songs.isEmpty ||
        controller.myPlaylist.isEmpty ||
        controller.failure != null) {
      try {
        setState(() => isLoading = true);
        await Future.wait([
          controller.getAllSong(),
          controller.getAllPlaylist(),
        ]);

        updateSongList();
        setState(() => isLoading = false);
      } on Failure catch (e) {
        setState(() => isLoading = false);
        controller.setFailure(e);
      }
    }
  }

  void updateSongList() {
    final controller = context.read<SongListController>();
    final songs = controller.myPlaylist;
    final allSongs = controller.songs;
    songs.addAll(allSongs);
    context.read<AudioPlayerController>().updateSongList(songs);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SongListController>(
      builder: (context, controller, _) {
        if (isLoading) {
          return const CustomLoadingIndicator();
        }

        final error = controller.failure;
        if (error != null) {
          return ErrorScreen(error: error, retry: getAllSongs);
        }

        return const CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            _MyPlayListSection(),
            _AllSongsSection(),
          ],
        );
      },
    );
  }
}

class _MyPlayListSection extends StatelessWidget {
  const _MyPlayListSection();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SongListController>();
    final songs = controller.myPlaylist;

    return SliverPadding(
      padding:
          controller.myPlaylist.isEmpty ? EdgeInsets.zero : EdgeInsets.only(top: 36.h),
      sliver: SliverToBoxAdapter(
        child: controller.myPlaylist.isEmpty
            ? const SizedBox.shrink()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: AppPadding.symetricHorizontalOnly,
                    child: Text(
                      'My Playlists',
                      style: AppText.bold500(context).copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    height: 170.h,
                    child: ListView.builder(
                      itemCount: songs.length,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: AppPadding.symetricHorizontalOnly,
                      itemBuilder: (context, index) {
                        final song = songs[index];
                        return MusicTile(
                          song: song,
                          smallMargin: true,
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _AllSongsSection extends StatelessWidget {
  const _AllSongsSection();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(top: 36.h),
      sliver: SliverToBoxAdapter(
        child: Consumer<SongListController>(
          builder: (context, controller, _) {
            if (controller.songs.isEmpty) {
              return const SizedBox.shrink();
            }

            final songs = controller.songs;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: AppPadding.symetricHorizontalOnly,
                  child: Text(
                    'All Songs Today',
                    style: AppText.bold500(context).copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                SongListView(
                  songs: songs,
                  verticalPadding: false,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
