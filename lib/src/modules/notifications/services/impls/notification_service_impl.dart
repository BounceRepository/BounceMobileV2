import 'dart:developer';

import 'package:bounce_patient_app/src/modules/notifications/models/notification_list_response.dart';
import 'package:bounce_patient_app/src/modules/notifications/services/impls/api_urls.dart';
import 'package:bounce_patient_app/src/modules/notifications/services/interfaces/notification_service.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationServiceImpl implements INotificationService {
  final IApi _api;
  final FirebaseMessaging _firebaseMessagingService;

  NotificationServiceImpl({
    required IApi api,
    required FirebaseMessaging firebaseMessagingService,
  })  : _api = api,
        _firebaseMessagingService = firebaseMessagingService;

  @override
  Future<NotificationListResponse> getAllNotification() async {
    try {
      final response = await _api.get(NotificationApiURLS.getAllNotification);
      final data = response['data'];
      return NotificationListResponse.fromJson(data);
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }

  @override
  Future<void> updateToken() async {
    try {
      final token = await _getTokenFromFirebase();

      if (token != null) {
        log(token);
        // var url = NotificationApiURLS.updateToken + '?token=$token';
        // await _api.patch(url, body: {});
      }
    } on Failure {
      rethrow;
    }
  }

  Future<String?> _getTokenFromFirebase() async {
    try {
      return await _firebaseMessagingService.getToken();
    } on Exception {
      throw InternalFailure();
    } on Error {
      throw InternalFailure();
    }
  }

  // void _onRefreshToken() async {
  //   _firebaseMessagingService.onTokenRefresh
  //       .listen(_service?.saveFirebaseTokenToDatabase);
  // }
}
