import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bounce_patient_app/src/shared/models/app_session.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';
import 'package:http/http.dart' as http;

class HttpApiServiceImpl implements IApi {
  @override
  Future<dynamic> get(String url, {Map<String, String>? headers}) async {
    headers ??= <String, String>{};

    final token = AppSession.authToken;
    if (token != null) {
      var authHeader = <String, String>{'Authorization': 'Bearer ' + token};
      headers.addAll(authHeader);
    }

    log("Url--" + url);
    headers.addAll({'Content-Type': 'application/json; charset=UTF-8'});
    log(json.encode(headers));

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode < 200 || response.statusCode > 299) {
        // get error response message
        var message = jsonDecode(response.body)['message'];
        if (message != null) {
          log(message.toString());
          throw Failure(message.toString());
        } else {
          message = 'Server error, try again later';
          throw Failure(message);
        }
      }

      var decodedData = jsonDecode(response.body);
      log("payload response --" + json.encode(decodedData));
      return decodedData;
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on HttpException {
      throw Failure('Server error, try again later');
    } on FormatException {
      throw Failure('Server error, try again later');
    }
  }

  @override
  Future<dynamic> post(
    String url, {
    required body,
    Map<String, String>? headers,
    bool isFormData = false,
  }) async {
    headers ??= <String, String>{};

    final token = AppSession.authToken;
    if (token != null) {
      var authHeader = <String, String>{'Authorization': 'Bearer ' + token};
      headers.addAll(authHeader);
    }

    log("Url--" + url);

    headers.addAll({'Content-Type': 'application/json; charset=UTF-8'});
    log('header - ' + json.encode(headers));
    var postValue = json.encode(body);
    log(postValue);

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: postValue);

      log("payload response --" + json.encode(response.body));

      if (response.statusCode < 200 || response.statusCode > 299) {
        // get error response message
        var message = jsonDecode(response.body)['message'];
        if (message != null) {
          var decodedData = jsonDecode(response.body);
          log("response - " + json.encode(decodedData));
          throw Failure(message);
        } else {
          message = 'Server error, try again later';
          throw Failure(message);
        }
      }

      var decodedData = jsonDecode(response.body);
      log("response - " + json.encode(decodedData));

      return decodedData;
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on HttpException {
      throw Failure('Server error, try again later');
    } on FormatException {
      throw Failure('Server error, try again later');
    } on Exception {
      throw Failure('Server error, try again later');
    }
  }

  @override
  Future delete({required String url}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future patch(
    String url, {
    required dynamic body,
    Map<String, String>? headers,
    bool isFormData = false,
  }) {
    // TODO: implement patch
    throw UnimplementedError();
  }

  @override
  Future put(String url, {required body, Map<String, String>? headers}) {
    // TODO: implement put
    throw UnimplementedError();
  }
}
