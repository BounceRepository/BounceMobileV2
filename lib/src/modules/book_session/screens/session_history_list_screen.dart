import 'package:bounce_patient_app/src/modules/book_session/controllers/session_list_controller.dart';
import 'package:bounce_patient_app/src/modules/book_session/models/session.dart';
import 'package:bounce_patient_app/src/modules/book_session/widgets/sessions_item_tile.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/sliver_appbar_delegate.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_loading_indicator.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/empty_view.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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
              _UpComingSessionListView(),
              _CompletedSessionListView(),
            ],
          ),
        ),
      ),
    );
  }
}

class _UpComingSessionListView extends StatefulWidget {
  const _UpComingSessionListView();

  @override
  State<_UpComingSessionListView> createState() => _UpComingSessionListViewState();
}

class _UpComingSessionListViewState extends State<_UpComingSessionListView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllUpcomingSession();
    });
  }

  void getAllUpcomingSession() async {
    final controller = context.read<SessionListController>();

    if (controller.upComingSessions.isEmpty || controller.failure != null) {
      try {
        await controller.getUpComingSessions();
      } on Failure catch (e) {
        controller.setFailure(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionListController>(
      builder: (context, controller, _) {
        if (controller.isBusy) {
          return const CustomLoadingIndicator();
        }

        final error = controller.failure;
        if (error != null) {
          return ErrorScreen(error: error, retry: getAllUpcomingSession);
        }

        if (controller.upComingSessions.isEmpty) {
          return const EmptyListView();
        }

        final sessions = controller.upComingSessions;
        return _SessionListView(sessions);
      },
    );
  }
}

class _CompletedSessionListView extends StatefulWidget {
  const _CompletedSessionListView();

  @override
  State<_CompletedSessionListView> createState() => _CompletedSessionListViewState();
}

class _CompletedSessionListViewState extends State<_CompletedSessionListView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllSession();
    });
  }

  void getAllSession() async {
    final controller = context.read<SessionListController>();

    if (controller.completedSessions.isEmpty || controller.failure != null) {
      try {
        await controller.getAllCompleted();
      } on Failure catch (e) {
        controller.setFailure(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionListController>(
      builder: (context, controller, _) {
        if (controller.isBusy) {
          return const CustomLoadingIndicator();
        }

        final error = controller.failure;
        if (error != null) {
          return Center(child: ErrorView(error: error, retry: getAllSession));
        }

        if (controller.completedSessions.isEmpty) {
          return const EmptyListView();
        }

        final sessions = controller.completedSessions;
        return _SessionListView(sessions);
      },
    );
  }
}

class _SessionListView extends StatelessWidget {
  const _SessionListView(this.sessions);

  final List<Session> sessions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: AppPadding.horizontal),
      itemCount: sessions.length,
      itemBuilder: (context, index) {
        final session = sessions[index];
        return SessionItemTile(session);
      },
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
