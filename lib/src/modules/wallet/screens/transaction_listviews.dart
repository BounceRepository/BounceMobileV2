import 'dart:developer';

import 'package:bounce_patient_app/src/modules/wallet/controllers/transaction_list_controller.dart';
import 'package:bounce_patient_app/src/modules/wallet/controllers/wallet_controller.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/transaction.dart';
import 'package:bounce_patient_app/src/modules/wallet/widgets/empty_transaction_list_view.dart';
import 'package:bounce_patient_app/src/modules/wallet/widgets/transaction_list_item.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/utils/messenger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AllTransactionListScreen extends StatefulWidget {
  const AllTransactionListScreen({super.key});

  @override
  State<AllTransactionListScreen> createState() => _AllTransactionListScreenState();
}

class _AllTransactionListScreenState extends State<AllTransactionListScreen> {
  void getTransactions() async {
    final controller = context.read<TransactionListController>();

    try {
      await controller.getAll();
    } on Failure catch (e) {
      Messenger.error(message: e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TransactionListController>();
    final transactions = controller.allTransactions;

    return _TransactionListView(transactions, onRefresh: getTransactions);
  }
}

class TopUpTransactionListScreen extends StatefulWidget {
  const TopUpTransactionListScreen({super.key});

  @override
  State<TopUpTransactionListScreen> createState() => _TopUpTransactionListScreenState();
}

class _TopUpTransactionListScreenState extends State<TopUpTransactionListScreen> {
  void getTransactions() async {
    final controller = context.read<TransactionListController>();

    try {
      await controller.getAllTopUp();
    } on Failure catch (e) {
      Messenger.error(message: e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TransactionListController>();
    final transactions = controller.topUpTransactions;

    return _TransactionListView(transactions, onRefresh: getTransactions);
  }
}

class PaymentTransactionListScreen extends StatefulWidget {
  const PaymentTransactionListScreen({super.key});

  @override
  State<PaymentTransactionListScreen> createState() =>
      _PaymentTransactionListScreenState();
}

class _PaymentTransactionListScreenState extends State<PaymentTransactionListScreen> {
  void getTransactions() async {
    final controller = context.read<TransactionListController>();

    try {
      await controller.getAllPayment();
    } on Failure catch (e) {
      Messenger.error(message: e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TransactionListController>();
    final transactions = controller.paymentTransactions;

    return _TransactionListView(transactions, onRefresh: getTransactions);
  }
}

class _TransactionListView extends StatelessWidget {
  const _TransactionListView(
    this.transactions, {
    Key? key,
    required this.onRefresh,
  }) : super(key: key);

  final List<Transaction> transactions;
  final Function() onRefresh;

  void getUpdatedBalance(BuildContext context) async {
    final controller = context.read<WalletController>();

    try {
      await controller.getBalance();
    } on Failure catch (e) {
      log('ERROR==> ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return const SingleChildScrollView(child: EmptyTransactionListView());
    }

    return RefreshIndicator(
      onRefresh: () async {
        getUpdatedBalance(context);
        onRefresh();
      },
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: AppPadding.horizontal),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return TransactionListItem(transaction);
        },
      ),
    );
  }
}
