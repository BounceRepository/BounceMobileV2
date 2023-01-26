import 'package:bounce_patient_app/src/modules/book_session/controllers/session_controller.dart';
import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/book_session/screens/therapist_booking_summary.dart';
import 'package:bounce_patient_app/src/modules/chat/screens/chat_window_screen.dart';
import 'package:bounce_patient_app/src/modules/reviews/screens/review_list_screen.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/bottom_navbar_container.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_child_scrollview.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/default_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class TherapistDetailScreen extends StatelessWidget {
  const TherapistDetailScreen(this.therapist, {Key? key}) : super(key: key);

  final Therapist therapist;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const CustomAppBar(backgroundColor: Colors.transparent),
        extendBodyBehindAppBar: true,
        body: ScrollToBottomListenerWidget(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 124.h,
                  bottom: 24.h,
                  right: AppPadding.horizontal,
                  left: AppPadding.horizontal,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.r),
                    bottomRight: Radius.circular(40.r),
                  ),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xffFEF3E7),
                      Color(0xffFCFAFA),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  children: [
                    CustomCacheNetworkImage(image: therapist.profilePicture, size: 100.h),
                    SizedBox(height: 24.h),
                    Text(
                      therapist.fullNameWithTitle,
                      textAlign: TextAlign.center,
                      style: AppText.bold700(context).copyWith(
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      therapist.specializationList,
                      textAlign: TextAlign.center,
                      style: AppText.bold400(context).copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 36.h),
                    Row(
                      children: [
                        infoCard(
                          context,
                          title: '${therapist.patientCount}+',
                          subTitle: 'Patients',
                        ),
                        SizedBox(width: 16.w),
                        infoCard(
                          context,
                          title: '${therapist.experience} Years',
                          subTitle: 'Experience',
                        ),
                        SizedBox(width: 16.w),
                        infoCard(
                          context,
                          title: '${therapist.rating}',
                          subTitle: 'Ratings',
                          onTap: () {
                            AppNavigator.to(
                                context, ReviewListScreen(therapist: therapist));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 24.h,
                  horizontal: AppPadding.horizontal,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    columnText(
                      context,
                      title: 'About',
                      description: therapist.about,
                    ),
                    SizedBox(height: 24.h),
                    columnText(
                      context,
                      title: 'Working Hours',
                      description: therapist.workingHours.toString(),
                    ),
                    SizedBox(height: 24.h),
                    _CommunicationSection(therapist: therapist),
                    SizedBox(height: 80.h),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBarContainer(
          child: AppButton(
            label: 'Book Session',
            onTap: () {
              AppNavigator.to(
                  context, TherapistBookingSummary(therapistId: therapist.id));
            },
          ),
        ),
      ),
    );
  }

  Widget infoCard(
    BuildContext context, {
    required String title,
    required String subTitle,
    Function()? onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(top: 28.h, bottom: 36.h),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: AppText.bold700(context).copyWith(
                  fontSize: 18.sp,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                subTitle,
                style: AppText.bold400(context).copyWith(
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget columnText(
    BuildContext context, {
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppText.bold600(context).copyWith(
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          description,
          style: AppText.bold400(context).copyWith(
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}

class _CommunicationSection extends StatelessWidget {
  const _CommunicationSection({Key? key, required this.therapist}) : super(key: key);

  final Therapist therapist;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Communication',
          textAlign: TextAlign.center,
          style: AppText.bold600(context).copyWith(
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 12.h),
        tile(
          context,
          icon: AppIcons.message,
          title: 'Messaging',
          subTitle: 'Chat and share photos.',
          onTap: () {
            final controller = context.read<SessionController>();

            if (!controller.inSession) {
              AppNavigator.to(
                  context, ChatWindowScreen(therapist: therapist, closed: true));
            }

            // if (controller.inSession) {

            //   // final specifictherapistIdInSession = controller.therapisId;

            //   // if (specifictherapistIdInSession != null &&
            //   //     specifictherapistIdInSession == therapist.id) {
            //   //   AppNavigator.to(context, ChatWindowScreen(therapist: therapist));
            //   // }
            // } else {
            //   AppNavigator.to(
            //       context, ChatWindowScreen(therapist: therapist, closed: true));
            // }
          },
        ),
        SizedBox(height: 20.h),
        tile(
          context,
          icon: AppIcons.call,
          title: 'Audio Call',
          subTitle: 'Place a call directly to your doctor.',
          onTap: () {},
        ),
        SizedBox(height: 20.h),
        tile(
          context,
          icon: AppIcons.video,
          title: 'Video Call',
          subTitle: 'Chat and share photos.',
          onTap: () {},
        ),
      ],
    );
  }

  Widget tile(
    BuildContext context, {
    required String icon,
    required String title,
    required String subTitle,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 12.h,
              horizontal: 12.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: const Color(0xffFCE7D8).withOpacity(.52),
            ),
            child: SvgPicture.asset(
              icon,
              height: 24.h,
              width: 24.h,
              fit: BoxFit.fill,
              color: AppColors.primary,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppText.bold600(context).copyWith(
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subTitle,
                  style: AppText.bold400(context).copyWith(
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
