import 'package:bounce_patient_app/src/modules/wallet/screens/top_up_bottomsheet.dart';
import 'package:bounce_patient_app/src/modules/wallet/widgets/transaction_list_item.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/sliver_appbar_delegate.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/amount_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = ['All', 'Top Up', 'Payment'];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: const CustomAppBar(label: 'My Wallet'),
        body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              const _BalanceSection(),
              _TabsSection(tabs),
            ];
          },
          body: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding:
                EdgeInsets.symmetric(vertical: 24.h, horizontal: AppPadding.horizontal),
            itemCount: 30,
            itemBuilder: (context, index) {
              return const TransactionListItem();
            },
          ),
        ),
      ),
    );
  }
}

class _BalanceSection extends StatelessWidget {
  const _BalanceSection();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(
        top: 20.h,
        left: AppPadding.horizontal,
        right: AppPadding.horizontal,
        bottom: 52.h,
      ),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            card(context: context, amount: 5000),
            SizedBox(height: 24.h),
            Text(
              'Top up your Bounce wallet and get 5% off your next 2 subscriptions when you pay with your wallet!',
              textAlign: TextAlign.center,
              style: AppText.bold400(context).copyWith(
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget card({
    required BuildContext context,
    required num amount,
  }) {
    return Stack(
      children: [
        Container(
          width: 344.w,
          height: 160.h,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        Positioned(
          right: 0,
          child: SvgPicture.asset(
            AppIcons.stetoscope,
            height: 193.82.h,
            width: 164.w,
            fit: BoxFit.cover,
            color: Colors.white,
          ),
        ),
        Positioned(
          top: 12.h,
          left: 16.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Available Balance',
                style: AppText.bold400(context).copyWith(
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 12.h),
              AmountText(
                amount: 5000,
                amountFontSize: 24.sp,
                color: Colors.white,
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: 132.w,
                height: 36.h,
                child: AppButton(
                  label: 'Top Up',
                  labelColor: AppColors.primary,
                  backgroundColor: AppColors.lightVersion,
                  borderRadius: BorderRadius.circular(8.r),
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  onTap: () {
                    showTopUpBottomsheet(context: context);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TabsSection extends StatelessWidget {
  const _TabsSection(this.tabs);

  final List<String> tabs;

  @override
  Widget build(BuildContext context) {
    final height = 100.h;

    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        maxHeight: height,
        minHeight: height,
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: AppPadding.symetricHorizontalOnly,
                child: Text(
                  'My Transactions',
                  style: AppText.bold600(context).copyWith(
                    fontSize: 16.sp,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.secondary, width: 1.h),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: TabBar(
                  tabs: List.generate(
                    tabs.length,
                    (index) {
                      final tab = tabs[index];
                      return Tab(text: tab);
                    },
                  ),
                  labelStyle: AppText.bold500(context).copyWith(
                    fontSize: 14.sp,
                  ),
                  indicatorColor: AppColors.primary,
                  indicatorWeight: 2.h,
                  indicator: const BoxDecoration(
                    color: AppColors.secondary,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
