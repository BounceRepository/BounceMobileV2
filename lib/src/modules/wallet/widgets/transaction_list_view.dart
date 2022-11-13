import 'package:bounce_patient_app/src/modules/wallet/models/transaction.dart';
import 'package:bounce_patient_app/src/modules/wallet/widgets/empty_transaction_list_view.dart';
import 'package:bounce_patient_app/src/modules/wallet/widgets/transaction_list_item.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionListView extends StatelessWidget {
  const TransactionListView(
    this.transactions, {
    Key? key,
  }) : super(key: key);

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return const EmptyTransactionListView();
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: AppPadding.horizontal),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return TransactionListItem(transaction);
      },
    );
  }
}