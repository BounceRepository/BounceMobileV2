// import 'dart:convert';
// import 'dart:developer';

// import 'package:bounce_patient_app/src/shared/network/api_service.dart';

// import 'payment_service_abstract.dart';


// class PaymentService implements IPaymentService {
//   final IApi _api;

//   PaymentService({required IApi api}) : _api = api;

//   @override
//   Future<Either<List<String>, PaymentDto>> initiate(PaymentDto paymentDto) async {
//     try {
//       final response = await _api.post(
//         url: PaymentUrls.initiate,
//         body: paymentDto.toJson(),
//         isSecure: true,
//       );
//       return response.fold(
//           (errors) => Left(errors), (data) => Right(PaymentDto.fromJson(data)));
//     } catch (e) {
//       return Left(['An error occired']);
//     }
//   }

//   @override
//   Future<Either<List<String>, Unit>> complete({
//     required PaymentStatus status,
//     required String trxRef,
//     required String transactionId,
//   }) async {
//     var body = {
//       "transactionReference": trxRef,
//       //"status": status.name,
//       "status": 'STATUS',
//       "transactionId": transactionId
//     };

//     try {
//       final response = await _api.post(
//           url: PaymentUrls.complete, body: json.encode(body), isSecure: true);
//       await pendingTransaction(trxRef);
//       return response.fold((errors) => Left(errors), (data) => Right(unit));
//     } catch (e) {
//       return Left(['An error occired']);
//     }
//   }

//   Future<void> pendingTransaction(String trxRef) async {
//     var url = '/golf-membership-payment/pending-transaction/GetItem/$trxRef';

//     try {
//       final response = await _api.get(url: url, isSecure: true);
//     } catch (e) {
//       log(e.toString());
//     }
//   }
// }
