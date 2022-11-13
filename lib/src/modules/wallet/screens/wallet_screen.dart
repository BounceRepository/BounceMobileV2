import 'package:bounce_patient_app/src/modules/wallet/controllers/transaction_list_controller.dart';
import 'package:bounce_patient_app/src/modules/wallet/controllers/wallet_controller.dart';
import 'package:bounce_patient_app/src/modules/wallet/screens/top_up_bottomsheet.dart';
import 'package:bounce_patient_app/src/modules/wallet/widgets/transaction_list_view.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/sliver_appbar_delegate.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/amount_text.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_loading_indicator.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  Failure? _error;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  void init() async {
    try {
      setState(() => isLoading = true);
      await Future.wait([
        getBalance(),
        getTransactions(),
      ]);
      setState(() => isLoading = false);
    } on Failure catch (e) {
      setState(() => isLoading = false);
      _error = e;
    }
  }

  Future<void> getBalance() async {
    final controller = context.read<WalletController>();

    try {
      await controller.getBalance();
    } on Failure {
      rethrow;
    }
  }

  Future<void> getTransactions() async {
    final controller = context.read<TransactionListController>();

    if (controller.transactions.isEmpty &&
        controller.topUTtransactions.isEmpty &&
        controller.paymentTransactions.isEmpty) {
      try {
        await Future.wait([
          controller.getAll(),
          controller.getAllPayment(),
          controller.getAllTopUp(),
        ]);
      } on Failure {
        rethrow;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: CustomLoadingIndicator());
    }

    final error = _error;
    if (error != null) {
      return ErrorScreen(error: error, retry: init);
    }

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
          body: const TabBarView(
            physics: BouncingScrollPhysics(),
            children: [
              AllTransactionListScreen(),
              TopUpTransactionListScreen(),
              PaymentTransactionListScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

class TopUpTransactionListScreen extends StatelessWidget {
  const TopUpTransactionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TransactionListController>();
    final transactions = controller.topUTtransactions;

    return TransactionListView(transactions);
  }
}

class AllTransactionListScreen extends StatelessWidget {
  const AllTransactionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TransactionListController>();
    final transactions = controller.transactions;

    return TransactionListView(transactions);
  }
}

class PaymentTransactionListScreen extends StatelessWidget {
  const PaymentTransactionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TransactionListController>();
    final transactions = controller.paymentTransactions;

    return TransactionListView(transactions);
  }
}

class _BalanceSection extends StatelessWidget {
  const _BalanceSection();

  @override
  Widget build(BuildContext context) {
    final balance = context.watch<WalletController>().balance;

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
            card(context: context, amount: balance),
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
                amount: amount,
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
    final height = 105.h;

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
