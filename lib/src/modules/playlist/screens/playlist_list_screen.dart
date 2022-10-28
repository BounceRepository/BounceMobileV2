import 'package:bounce_patient_app/src/modules/playlist/widgets/music_list_tile.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
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
            body: const _Body(),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        _MyPlayListSection(),
        _AllSongsSection(),
      ],
    );
  }
}

class _MyPlayListSection extends StatelessWidget {
  const _MyPlayListSection();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(top: 36.h),
      sliver: SliverToBoxAdapter(
        child: Column(
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
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: AppPadding.symetricHorizontalOnly,
                itemBuilder: (context, index) {
                  return const MusicTile(smallMargin: true);
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
        child: Column(
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
            ListView.builder(
              itemCount: 30,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: AppPadding.symetricHorizontalOnly,
              itemBuilder: (context, index) {
                return MusicTile(
                  height: 170.h,
                  bottomPadding: true,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
