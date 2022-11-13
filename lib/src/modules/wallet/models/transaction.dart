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
    return Transaction(
      id: json['transactionId'] as String,
      title: json['title'] as String,
      desc: json['message'] as String,
      amount: json['amount'] as num,
      createdAt: json['time'] as String,
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
  if(str.toLowerCase() == 'TOPUP') {
    return TransactionType.credit;
  } else {
    return TransactionType.debit;
  }
}
