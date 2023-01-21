import 'package:bounce_patient_app/src/modules/book_session/controllers/session_list_controller.dart';
import 'package:bounce_patient_app/src/modules/book_session/screens/join_session_screen.dart';
import 'package:bounce_patient_app/src/modules/book_session/widgets/sessions_item_tile.dart';
import 'package:bounce_patient_app/src/modules/book_session/widgets/today_session_card.dart';
import 'package:bounce_patient_app/src/modules/dashboard/screens/dashboard_view.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UpComingSessionListScreen extends StatefulWidget {
  const UpComingSessionListScreen({Key? key}) : super(key: key);

  @override
  State<UpComingSessionListScreen> createState() => _UpComingSessionListScreenState();
}

class _UpComingSessionListScreenState extends State<UpComingSessionListScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      init();
    });
  }

  void init() async {
    final controller = context.read<SessionListController>();

    if (controller.sessions.isEmpty ||
        controller.upComingSessions.isEmpty ||
        controller.failure != null) {
      try {
        setState(() => isLoading = true);
        await Future.wait([
          controller.getAllCompleted(),
          controller.getUpComingSessions(),
        ]);
        setState(() => isLoading = false);
      } on Failure catch (e) {
        setState(() => isLoading = false);
        controller.setFailure(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        AppNavigator.removeAllUntil(context, const DashboardView());
        return Future.value(true);
      },
      child: Scaffold(
        appBar: CustomAppBar(
          label: 'Upcoming Sessions',
          leading: BackButton(
            onPressed: () {
              AppNavigator.removeAllUntil(context, const DashboardView());
            },
          ),
        ),
        body: Consumer<SessionListController>(
          builder: (context, controller, _) {
            if (controller.upComingSessions.isEmpty) {
              return const SizedBox.shrink();
            }

            final sessions = controller.upComingSessions;
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: AppPadding.defaultPadding,
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final session = sessions[index];
                return SessionItemTile(session);
              },
            );
          },
        ),
      ),
    );
  }
}

class _UpcomingSessionCard extends StatelessWidget {
  const _UpcomingSessionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<SessionListController>(
        builder: (context, controller, _) {
          if (controller.upComingSessions.isEmpty) {
            return const SizedBox.shrink();
          }

          final sessions = controller.todayUpComingSessions;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Padding(
                padding: AppPadding.symetricHorizontalOnly,
                child: Text(
                  'Today',
                  style: AppText.bold500(context).copyWith(
                    fontSize: 16.sp,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 145.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: sessions.length,
                  padding: AppPadding.symetricHorizontalOnly,
                  itemBuilder: (context, index) {
                    final session = sessions[index];
                    return TodaySessionCard(session);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 12.w);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget bookNowButton(BuildContext context, int therapistId) {
    return GestureDetector(
      onTap: () {
       // AppNavigator.to(context, JoinSessionScreen(therapistId: therapistId));
      },
      child: Text(
        'Join Now',
        style: AppText.bold700(context).copyWith(
          fontSize: 16.sp,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

class _AllSessionSection extends StatelessWidget {
  const _AllSessionSection();

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionListController>(
      builder: (context, controller, _) {
        if (controller.upComingSessions.isEmpty) {
          return const SizedBox.shrink();
        }

        final sessions = controller.upComingSessions;
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: AppPadding.symetricHorizontalOnly,
          itemCount: sessions.length,
          itemBuilder: (context, index) {
            final session = sessions[index];
            return SessionItemTile(session);
          },
        );
      },
    );
  }
}
