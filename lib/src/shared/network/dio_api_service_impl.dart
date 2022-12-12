import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bounce_patient_app/src/shared/models/app_session.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';
import 'package:dio/dio.dart';

class DioApiServiceImpl implements IApi {
  final dio = Dio();

  @override
  Future delete({
    required String url,
    Map<String, String>? headers,
  }) async {
    headers ??= <String, String>{};

    final token = AppSession.authToken;
    if (token != null) {
      var authHeader = <String, String>{'Authorization': 'Bearer ' + token};
      dio.options.headers.addAll(authHeader);
    }

    log('URL==>$url');
    log('HEADERS==>${dio.options.headers}');

    try {
      final response = await dio.delete(url);

      if (response.statusCode == 200) {
        log('PAYLOAD==>${response.data}');
        return response.data;
      }
    } on DioError catch (e) {
      final response = e.response;

      if (response != null) {
        log('ERROR==>${response.data}');
        final message = response.data['message'];
        if (message != null) {
          throw Failure(message);
        }
      }

      throw InternalFailure();
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on FormatException {
      throw InternalFailure();
    } on Error {
      throw InternalFailure();
    }
  }

  @override
  Future get(String url, {Map<String, String>? headers}) async {
    headers ??= <String, String>{};

    final token = AppSession.authToken;
    if (token != null) {
      var authHeader = <String, String>{'Authorization': 'Bearer ' + token};
      dio.options.headers.addAll(authHeader);
    }

    log('URL==>$url');
    log('HEADERS==>${dio.options.headers}');

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        log('PAYLOAD==>${response.data}');
        return response.data;
      }
    } on DioError catch (e) {
      final response = e.response;

      if (response != null) {
        log('ERROR==>${response.data}');
        final message = response.data['message'];
        if (message != null) {
          throw Failure(message);
        }
      }

      throw InternalFailure();
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on FormatException {
      throw InternalFailure();
    } on Error {
      throw InternalFailure();
    }
  }

  @override
  Future patch(
    String url, {
    required body,
    Map<String, String>? headers,
    bool isFormData = false,
  }) async {
    headers ??= <String, String>{};

    final token = AppSession.authToken;
    if (token != null) {
      var authHeader = <String, String>{'Authorization': 'Bearer ' + token};
      dio.options.headers.addAll(authHeader);
    }

    dynamic data;
    if (isFormData) {
      data = body;
    } else {
      data = json.encode(body);
    }

    log('URL==>$url');
    log('HEADERS==>${dio.options.headers}');
    if (isFormData) {
      log('BODY==>${data.fields.toString()}');
    } else {
      log('BODY==>$data');
    }

    try {
      final response = await dio.patch(url, data: body);
      if (response.statusCode == 200) {
        log('PAYLOAD==>${response.data}');
        return response.data;
      }
    } on DioError catch (e) {
      final response = e.response;

      if (response != null) {
        log('ERROR==>${response.data}');
        final message = response.data['message'];
        if (message != null) {
          throw Failure(message);
        }
      }

      throw InternalFailure();
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on FormatException {
      throw InternalFailure();
    } on Error {
      throw InternalFailure();
    }
  }

  @override
  Future post(
    String url, {
    required body,
    Map<String, String>? headers,
    bool isFormData = false,
  }) async {
    headers ??= <String, String>{};

    final token = AppSession.authToken;
    if (token != null) {
      var authHeader = <String, String>{'Authorization': 'Bearer ' + token};
      dio.options.headers.addAll(authHeader);
    }

    dynamic data;
    if (isFormData) {
      data = body;
    } else {
      data = json.encode(body);
    }

    log('URL==>$url');
    log('HEADERS==>${dio.options.headers}');
    if (isFormData) {
      log('BODY==>${data.fields.toString()}');
    } else {
      log('BODY==>$data');
    }

    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        log('PAYLOAD==>${response.data}');
        return response.data;
      }
    } on DioError catch (e) {
      final response = e.response;

      if (response != null) {
        log('ERROR==>${response.data}');
        final message = response.data['message'];
        if (message != null) {
          throw Failure(message);
        }
      }

      throw InternalFailure();
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on FormatException {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    } on Error {
      throw InternalFailure();
    }
  }

  @override
  Future put(String url, {required body, Map<String, String>? headers}) async {
    headers ??= <String, String>{};

    final token = AppSession.authToken;
    if (token != null) {
      var authHeader = <String, String>{'Authorization': 'Bearer ' + token};
      dio.options.headers.addAll(authHeader);
    }

    var data = json.encode(body);

    log('URL==>$url');
    log('HEADERS==>${dio.options.headers}');
    log('BODY==>$data');

    try {
      final response = await dio.put(url, data: data);
      if (response.statusCode == 200) {
        log('PAYLOAD==>${response.data}');
        return response.data;
      }
    } on DioError {
      throw InternalFailure();
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on FormatException {
      throw InternalFailure();
    } on Error {
      throw InternalFailure();
    }
  }
}
