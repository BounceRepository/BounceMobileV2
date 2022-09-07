import 'package:bounce_patient_app/src/modules/chat/widgets/room_item_tile.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_tabbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/sliver_appbar_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({Key? key}) : super(key: key);

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> with SingleTickerProviderStateMixin {
  late final TabController tabController;
  final tabs = ['Trending', 'Relationship', 'Self Care', 'Self Care'];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(child: CustomAppBar()),
            SliverPersistentHeader(
              pinned: true,
              //floating: true,
              delegate: SliverAppBarDelegate(
                minHeight: 115.h,
                maxHeight: 115.h,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 25.h),
                      Padding(
                        padding: AppPadding.symetricHorizontalOnly,
                        child: Text(
                          'Rant Room',
                          style: AppText.bold600(context).copyWith(
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      CustomTabBar(
                        controller: tabController,
                        isScrollable: true,
                        onTap: (_) {
                          setState(() {});
                        },
                        tabs: List.generate(tabs.length, (index) {
                          final tab = tabs[index];
                          return CustomTab(
                            text: tab,
                            controller: tabController,
                            index: index,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => const RoomItemTile(),
                childCount: 30,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 58.h,
        width: 58.h,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: AppColors.chatRoom,
            elevation: 0,
            onPressed: () {},
            child: Icon(
              Icons.edit_outlined,
              size: 20.sp,
            ),
          ),
        ),
      ),
    );
  }
}
