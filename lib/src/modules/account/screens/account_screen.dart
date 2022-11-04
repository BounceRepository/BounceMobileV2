import 'package:bounce_patient_app/src/modules/account/screens/contact_us_bottomsheet.dart';
import 'package:bounce_patient_app/src/modules/account/screens/log_out_bottomsheet.dart';
import 'package:bounce_patient_app/src/modules/book_session/screens/session_history_list_screen.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/sign_in_screen.dart';
import 'package:bounce_patient_app/src/modules/dashboard/screens/dashboard_view.dart';
import 'package:bounce_patient_app/src/modules/journal/screens/journal_list_screen.dart';
import 'package:bounce_patient_app/src/modules/playlist/screens/discover_screen.dart';
import 'package:bounce_patient_app/src/modules/subscription/screens/care_plans_screen.dart';
import 'package:bounce_patient_app/src/modules/wallet/screens/wallet_screen.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/assets/images.dart';
import 'package:bounce_patient_app/src/shared/extensions/string.dart';
import 'package:bounce_patient_app/src/shared/models/app_session.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_child_scrollview.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/default_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = AppSession.user;

    if (user == null) {
      return const SizedBox.shrink();
    }

    return Scaffold(
      body: SafeArea(
        child: CustomChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppImageView(
                    AppImages.image,
                    size: 68.h,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    user.userName.toTitleCase,
                    style: AppText.bold700(context).copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              const _BookSessionCard(),
              SizedBox(height: 32.h),
              const _MenuListSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _BookSessionCard extends StatelessWidget {
  const _BookSessionCard();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 344.w,
          height: 140.h,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        Positioned(
          top: 12.h,
          left: 8.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 136.w,
                child: Text(
                  'Therapists Available Now!',
                  style: AppText.bold500(context).copyWith(
                    fontSize: 18.sp,
                    color: AppColors.lightVersion,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              bookSessionButton(context),
            ],
          ),
        ),
        Positioned(
          right: 0,
          child: Image.asset(
            AppImages.doctors,
            height: 140.h,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget bookSessionButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.to(context, const DashboardView(selectedIndex: 1));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w),
        decoration: BoxDecoration(
          color: AppColors.lightVersion,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          'Book Session',
          style: AppText.bold700(context).copyWith(
            fontSize: 8.sp,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}

class _MenuListSection extends StatelessWidget {
  const _MenuListSection();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24.h,
      direction: Axis.vertical,
      children: [
        title(
          context: context,
          icon: AccountIcons.plan,
          title: 'My Care Plans',
          onTap: () {
            AppNavigator.to(context, const CarePlansScreen());
          },
        ),
        title(
          context: context,
          icon: AccountIcons.wallet,
          title: 'My Wallet',
          onTap: () {
            AppNavigator.to(context, const WalletScreen());
          },
        ),
        title(
          context: context,
          icon: AccountIcons.journal,
          title: 'My Journal',
          onTap: () {
            AppNavigator.to(context, const JournalListScreen());
          },
        ),
        title(
          context: context,
          icon: AccountIcons.discover,
          title: 'Discover',
          onTap: () {
            AppNavigator.to(context, const DiscoverScreen());
          },
        ),
        title(
          context: context,
          icon: AccountIcons.session,
          title: 'Session History',
          onTap: () {
            AppNavigator.to(context, const SessionHistoryListScreen());
          },
        ),
        title(
          context: context,
          icon: AccountIcons.help,
          title: 'Help',
          onTap: () {
            showContactUsBottomsheet(context: context);
          },
        ),
        title(
          context: context,
          icon: AccountIcons.logout,
          title: 'Log Out',
          color: AppColors.error,
          onTap: () {
            showLogoutBottomsheet(context: context);
           
          },
        ),
      ],
    );
  }

  Widget title({
    required BuildContext context,
    required String icon,
    required String title,
    Color? color,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 344.w,
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 8.24.w),
        decoration: BoxDecoration(
          color: AppColors.lightVersion,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: AppColors.boxshadow4,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              height: 24.h,
              width: 24.h,
              fit: BoxFit.cover,
              color: color ?? AppColors.lightText,
            ),
            SizedBox(width: 24.w),
            Text(
              title,
              style: AppText.bold400(context).copyWith(
                color: color ?? AppColors.lightText,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
