import 'package:bounce_patient_app/src/modules/playlist/models/song.dart';
import 'package:bounce_patient_app/src/modules/playlist/screens/song_tabs/all_song_list_view.dart';
import 'package:bounce_patient_app/src/modules/playlist/screens/song_tabs/happy_song_list_view.dart';
import 'package:bounce_patient_app/src/modules/playlist/screens/song_tabs/love_song_list_view.dart';
import 'package:bounce_patient_app/src/modules/playlist/screens/song_tabs/nature_song_list_view.dart';
import 'package:bounce_patient_app/src/modules/playlist/screens/song_tabs/sad_song_list_view.dart';
import 'package:bounce_patient_app/src/modules/playlist/screens/song_tabs/work_song_list_view.dart';
import 'package:bounce_patient_app/src/modules/playlist/widgets/music_list_tile.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlayListScreen extends StatelessWidget {
  const PlayListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabs = [
      'All',
      'Happy',
      'Sad',
      'Love',
      'Work',
      'Nature',
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        body: SafeArea(
          child: NestedScrollView(
            physics: const BouncingScrollPhysics(),
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                AppBarWithTabs(
                  title: 'Music',
                  tabs: tabs,
                ),
              ];
            },
            body: const TabBarView(
              physics: BouncingScrollPhysics(),
              children: [
                AllSongsView(),
                HaapySongListView(),
                SadSongListView(),
                LoveSongListView(),
                WorkSongListView(),
                NatureSongListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SongListView extends StatelessWidget {
  const SongListView({
    Key? key,
    required this.songs,
    this.verticalPadding = true,
  }) : super(key: key);

  final List<Song> songs;
  final bool verticalPadding;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: songs.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding ? 36.h : 0,
        horizontal: AppPadding.horizontal,
      ),
      itemBuilder: (context, index) {
        final song = songs[index];
        return MusicTile(
          song: song,
          height: 170.h,
          bottomPadding: true,
        );
      },
    );
  }
}
