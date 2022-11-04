import 'package:bounce_patient_app/src/modules/book_session/controllers/session_list_controller.dart';
import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/book_session/screens/join_session_screen.dart';
import 'package:bounce_patient_app/src/modules/book_session/widgets/sessions_item_tile.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_loading_indicator.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/empty_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UpComingSessionListScreen extends StatefulWidget {
  const UpComingSessionListScreen({Key? key}) : super(key: key);

  @override
  State<UpComingSessionListScreen> createState() => _UpComingSessionListScreenState();
}

class _UpComingSessionListScreenState extends State<UpComingSessionListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllUpcomingSession();
      getAllSession();
    });
  }

  void getAllUpcomingSession() async {
    final controller = context.read<SessionListController>();

    if (controller.upComingSessions.isEmpty) {
      try {
        await controller.getUpComingSessions();
      } on Failure catch (e) {
        controller.setFailure(e);
      }
    }
  }

  void getAllSession() async {
    final controller = context.read<SessionListController>();

    if (controller.sessions.isEmpty) {
      try {
        await controller.getAllSession();
      } on Failure catch (e) {
        controller.setFailure(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(label: 'New Session'),
      body: Consumer<SessionListController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return const CustomLoadingIndicator();
          }

          if (controller.failure != null) {
            // show error view
          }

          if (controller.upComingSessions.isEmpty && controller.sessions.isEmpty) {
            return const EmptyListView();
          }

          return NestedScrollView(
            physics: const BouncingScrollPhysics(),
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                const _UpcomingSessionCard(),
                SliverPadding(
                  padding: EdgeInsets.only(
                    top: 20.h,
                    left: AppPadding.horizontal,
                    bottom: 20.h,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      'This Month',
                      style: AppText.bold500(context).copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: const _AllSessionSection(),
          );
        },
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

          final session = controller.upComingSessions.first;
          final therapist = session.therapist;
          return Padding(
            padding: AppPadding.symetricHorizontalOnly,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text(
                  'Today',
                  style: AppText.bold500(context).copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    top: 23.12.h,
                    bottom: 23.12.h,
                    left: 20.w,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(.52),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Upcoming Session',
                        style: AppText.bold700(context).copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '${therapist.fullName}, ${therapist.certifications.first} in ${therapist.specializations.first}',
                        style: AppText.bold400(context).copyWith(
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        session.period,
                        style: AppText.bold600(context).copyWith(
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 11.18.h),
                      bookNowButton(context, session.therapist),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget bookNowButton(BuildContext context, Therapist therapist) {
    return GestureDetector(
      onTap: () {
        AppNavigator.to(context, JoinSessionScreen(therapist: therapist));
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
        if (controller.sessions.isEmpty) {
          return const SizedBox.shrink();
        }

        final sessions = controller.sessions;
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
