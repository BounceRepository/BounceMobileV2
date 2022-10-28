import 'package:bounce_patient_app/src/modules/appointment/widgets/sessions_item_tile.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/sliver_appbar_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SessionHistoryListScreen extends StatelessWidget {
  const SessionHistoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = ['Upcoming', 'Completed'];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const CustomAppBar(label: 'History'),
        body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              _TabsSection(tabs),
            ];
          },
          body: const TabBarView(
            physics: BouncingScrollPhysics(),
            children: [
              _SessionListView(),
              _SessionListView(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabsSection extends StatelessWidget {
  const _TabsSection(this.tabs);

  final List<String> tabs;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        maxHeight: 52.h,
        minHeight: 40.h,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: AppColors.grey6,
                width: 2.h,
              ),
            ),
          ),
          child: TabBar(
            tabs: List.generate(
              tabs.length,
              (index) {
                final tab = tabs[index];
                return Tab(text: tab);
              },
            ),
            labelStyle: AppText.bold400(context).copyWith(
              fontSize: 14.sp,
            ),
            indicatorColor: AppColors.primary,
            indicatorWeight: 2.h,
          ),
        ),
      ),
    );
  }
}

class _SessionListView extends StatelessWidget {
  const _SessionListView();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: AppPadding.horizontal),
      itemCount: 30,
      itemBuilder: (context, index) {
        return const SessionItemTile();
      },
    );
  }
}
