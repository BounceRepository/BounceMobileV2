import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:bounce_patient_app/src/shared/models/datastore.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

class RequestHelper {
  static Future<dynamic> getRequest(String url, {Map<String, String>? header}) async {
    header ??= <String, String>{};

    final token = DataStore.authToken;
    if (token != null) {
      var authHeader = <String, String>{'Authorization': 'Bearer ' + token};
      header.addAll(authHeader);
    }

    log("Url--" + url);
    header.addAll({'Content-Type': 'application/json; charset=UTF-8'});
    log(json.encode(header));

    try {
      final response = await http.get(Uri.parse(url), headers: header);

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

  static Future<dynamic> postRequest(String url, dynamic values,
      {Map<String, String>? header}) async {
    header ??= <String, String>{};

    final token = DataStore.authToken;
    if (token != null) {
      var authHeader = <String, String>{'Authorization': 'Bearer ' + token};
      header.addAll(authHeader);
    }

    log("Url--" + url);

    header.addAll({'Content-Type': 'application/json; charset=UTF-8'});
    log('header - ' + json.encode(header));
    var postValue = json.encode(values);
    log(postValue);

    try {
      final response = await http.post(
        Uri.parse(url),
        //headers: header,
        body: postValue,
      );

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
}
