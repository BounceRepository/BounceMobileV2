import 'package:bounce_patient_app/src/shared/utils/datetime_utils.dart';

enum TransactionType {
  credit,
  debit,
}

class Transaction {
  final String id;
  final String title;
  final String desc;
  final num amount;
  final String createdAt;
  final TransactionType type;

  Transaction({
    required this.id,
    required this.title,
    required this.desc,
    required this.amount,
    required this.createdAt,
    required this.type,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    final date = DateTime.parse(json["time"]);
    return Transaction(
      id: json['transactionId'] as String,
      title: json['transactionType'] as String,
      desc: json['paymentDescription'] as String,
      amount: json['amount'] as num,
      createdAt:
          '${DateTimeUtils.getDateFullStr(date)} ${DateTimeUtils.convertDateTimeToAMPM(date)}',
      type: _getType(json['transactionType']),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'desc': desc,
      'amount': amount,
      'createdAt': createdAt,
    };
  }
}

TransactionType _getType(String str) {
  if (str.toLowerCase() == 'topup') {
    return TransactionType.credit;
  } else {
    return TransactionType.debit;
  }
}
