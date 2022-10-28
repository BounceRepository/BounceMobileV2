import 'package:bounce_patient_app/src/modules/chat/widgets/room_item_tile.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_tabbar.dart';
import 'package:flutter/material.dart';

class RoomScreen extends StatelessWidget {
  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = [
      'Trending',
      'Relationship',
      'Self Care',
      'Work Ethics',
      'Family',
      'Sexuality',
      'Parenting',
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
                  title: 'Chat',
                  tabs: tabs,
                ),
              ];
            },
            body: const _RoomChatListView(),
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
    return Scaffold(
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 30,
        itemBuilder: (context, index) {
          return const RoomChatItem();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
