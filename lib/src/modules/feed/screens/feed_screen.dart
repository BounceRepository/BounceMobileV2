import 'package:bounce_patient_app/src/modules/feed/controllers/feed_controller.dart';
import 'package:bounce_patient_app/src/modules/feed/models/feed.dart';
import 'package:bounce_patient_app/src/modules/feed/screens/add_feed_screen.dart';
import 'package:bounce_patient_app/src/modules/feed/widgets/feed_item_tile.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_tabbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_loading_indicator.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/empty_view.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/error_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final tabs = feedGroups.map((element) => element.name).toList();

    return DefaultTabController(
      length: tabs.length,
      initialIndex: widget.initialIndex,
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
            body: const TabBarView(
              physics: BouncingScrollPhysics(),
              children: [
                //FeedListView<MyFeedController>(),
                FeedListView<RelationShipFeedController>(),
                FeedListView<SelfCareFeedController>(),
                FeedListView<WorkEthnicsFeedController>(),
                FeedListView<FamilyFeedController>(),
                FeedListView<SexualityFeedController>(),
                FeedListView<ParentingFeedController>(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FeedListView<T extends FeedController> extends StatefulWidget {
  const FeedListView({super.key});

  @override
  State<FeedListView<T>> createState() => _FeedListViewState<T>();
}

class _FeedListViewState<T extends FeedController> extends State<FeedListView<T>> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getFeedList();
    });
  }

  void getFeedList() async {
    final controller = context.read<T>();

    if (controller.feeds.isEmpty) {
      try {
        await controller.getFeedList();
      } on Failure catch (e) {
        controller.setFailure(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<T>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return const CustomLoadingIndicator();
          }

          final error = controller.failure;
          if (error != null) {
            return ErrorScreen(error: error, retry: getFeedList);
          }

          if (controller.feeds.isEmpty) {
            return const EmptyListView();
          }

          final feeds = controller.feeds;
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: feeds.length,
            itemBuilder: (context, index) {
              final feed = feeds[index];
              return FeedItemTile<T>(feed);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppNavigator.to(context, AddFeedScreen<T>());
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
