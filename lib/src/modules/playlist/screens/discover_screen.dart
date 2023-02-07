import 'package:bounce_patient_app/src/modules/playlist/screens/song_tabs/song_tabs.dart';
import 'package:bounce_patient_app/src/modules/playlist/widgets/discover_list_item.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = [
      'All',
      'Sleep',
      'Anxiety',
      'Personal Growth',
      'Relationship',
      'Work',
      'Family',
      'Podcasts',
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: const CustomAppBar(label: 'Discover'),
        body: SafeArea(
          bottom: false,
          child: NestedScrollView(
            physics: const BouncingScrollPhysics(),
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                //AppBarWithTabs(tabs: tabs),
              ];
            },
            body: const HappySongListView(),
          ),
        ),
      ),
    );
  }
}

class _RoomChatListView extends StatelessWidget {
  const _RoomChatListView();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(
        vertical: 36.h,
        horizontal: AppPadding.horizontal,
      ),
      itemCount: 30,
      itemBuilder: (context, index) {
        return const DiscoverListItem();
      },
    );
  }
}
