enum PaymentProvider {
  flutterwave,
  paystack,
}

enum PaymentStatus {
  success,
  failed,
  pending,
}

class PaymentDto {
  PaymentDto({
    required this.trxRef,
    required this.customerName,
    required this.email,
    required this.amount,
    required this.narration,
    required this.message,
  });

  final String trxRef;
  final String customerName;
  final String email;
  final int amount;
  final String narration;
  final String message;

  // factory PaymentDto.fromJson(Map<String, dynamic> json) => PaymentDto(
  //       trxRef: json["sessionId"],
  //       customerName: json["customerName"],
  //       email: json["email"],
  //       amount: json["amount"].toInt(),
  //       narration: json["narration"],
  //       message: json["message"],
  //     );

  // String toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};

  //   data['customerName'] = customerName;
  //   data['email'] = email;
  //   data['amount'] = amount;
  //   data['narration'] = narration;
  //   data['message'] = message;

  //   return json.encode(data);
  // }
}
