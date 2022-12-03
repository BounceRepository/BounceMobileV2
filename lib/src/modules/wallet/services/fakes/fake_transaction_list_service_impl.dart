import 'dart:math';

import 'package:bounce_patient_app/src/modules/wallet/models/transaction.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/interfaces/transaction_list_service.dart';
import 'package:bounce_patient_app/src/shared/utils/utils.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class FakeTransactionListServiceImpl implements ITransactionListService {
  final random = Random();

  @override
  Future<List<Transaction>> getAll() async {
    await fakeNetworkDelay();
    return List.generate(
        random.nextInt(25),
        (index) => Transaction(
              id: Utils.getGuid(),
              title: lorem(paragraphs: 1, words: random.nextInt(5) + 2),
              desc: lorem(paragraphs: 1, words: random.nextInt(5) + 2),
              amount: random.nextInt(10000) + 1000,
              createdAt: 'Thu, 03 Nov 2022 16:54 PM',
              type: _getType(random.nextBool()),
            ));
  }

  @override
  Future<List<Transaction>> getAllPayment() async {
    await fakeNetworkDelay();
    return List.generate(
        random.nextInt(25),
        (index) => Transaction(
              id: Utils.getGuid(),
              title: lorem(paragraphs: 1, words: random.nextInt(5) + 2),
              desc: lorem(paragraphs: 1, words: random.nextInt(5) + 2),
              amount: random.nextInt(10000) + 1000,
              createdAt: 'Thu, 03 Nov 2022 16:54 PM',
              type: TransactionType.debit,
            ));
  }

  @override
  Future<List<Transaction>> getAllTopUp() async {
    await fakeNetworkDelay();
    return List.generate(
        random.nextInt(25),
        (index) => Transaction(
              id: Utils.getGuid(),
              title: lorem(paragraphs: 1, words: random.nextInt(5) + 2),
              desc: lorem(paragraphs: 1, words: random.nextInt(5) + 2),
              amount: random.nextInt(10000) + 1000,
              createdAt: 'Thu, 03 Nov 2022 16:54 PM',
              type: TransactionType.credit,
            ));
  }
}

TransactionType _getType(bool value) {
  if (value == true) {
    return TransactionType.credit;
  } else {
    return TransactionType.debit;
  }
}
