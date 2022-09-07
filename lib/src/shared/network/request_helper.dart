import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:bounce_patient_app/src/shared/models/datastore.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

abstract class IRequestHelper {
  Future<dynamic> get(
    String url, {
    Map<String, String>? headers,
  });
  Future<dynamic> post(
    String url, {
    required dynamic body,
    Map<String, String>? headers,
    bool isFormData = false,
  });
  Future<dynamic> put(
    String url, {
    required dynamic body,
    Map<String, String>? headers,
  });
  Future<dynamic> patch(
    String url, {
    required dynamic body,
    Map<String, String>? headers,
  });
  Future<dynamic> delete({required String url});
}

class DioRequestHelper implements IRequestHelper {
  final dio = Dio();

  @override
  Future delete({required String url}) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future get(String url, {Map<String, String>? headers}) async {
    if (headers != null) {
      dio.options.headers.addAll(headers);
    }

    log('URL--$url');
    log('HEADERS--${dio.options.headers}');

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        log('PAYLOAD--${response.data}');
        return response.data;
      }
    } on DioError {
      throw Failure('An error occuried');
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on FormatException {
      throw Failure('Input error');
    }
  }

  @override
  Future patch(String url, {required body, Map<String, String>? headers}) async {
    if (headers != null) {
      dio.options.headers.addAll(headers);
    }

    var data = json.encode(body);

    log('URL--$url');
    log('HEADERS--${dio.options.headers}');
    log('BODY--$data');

    try {
      final response = await dio.patch(url, data: data);
      if (response.statusCode == 200) {
        log('PAYLOAD--${response.data}');
        return response.data;
      }
    } on DioError {
      throw Failure('An error occuried');
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on FormatException {
      throw Failure('Input error');
    }
  }

  @override
  Future post(String url,
      {required body, Map<String, String>? headers, bool isFormData = false}) async {
    if (headers != null) {
      dio.options.headers.addAll(headers);
    }
    dynamic data;
    if (isFormData) {
      data = body;
    } else {
      data = json.encode(body);
    }

    log('URL--$url');
    log('HEADERS--${dio.options.headers}');
    if (isFormData) {
      log('BODY--${data.fields.toString()}');
    } else {
      log('BODY--$data');
    }

    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        log('PAYLOAD--${response.data}');
        return response.data;
      }
    } on DioError catch (e) {
      final response = e.response;

      if (response != null) {
        log('ERROR--${response.data}');
        final message = response.data['message'];
        if (message != null) {
          throw Failure(message);
        }
      }

      throw Failure('Server error, try again later');
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on FormatException {
      throw Failure('Input error');
    }
  }

  @override
  Future put(String url, {required body, Map<String, String>? headers}) async {
    if (headers != null) {
      dio.options.headers.addAll(headers);
    }

    var data = json.encode(body);

    log('URL--$url');
    log('HEADERS--${dio.options.headers}');
    log('BODY--$data');

    try {
      final response = await dio.put(url, data: data);
      if (response.statusCode == 200) {
        log('PAYLOAD--${response.data}');
        return response.data;
      }
    } on DioError {
      throw Failure('An error occuried');
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on FormatException {
      throw Failure('Input error');
    }
  }
}

class HttpRequestHelper implements IRequestHelper {
  @override
  Future<dynamic> get(String url, {Map<String, String>? headers}) async {
    headers ??= <String, String>{};

    final token = DataStore.authToken;
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

    final token = DataStore.authToken;
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
  Future patch(String url, {required body, Map<String, String>? headers}) {
    // TODO: implement patch
    throw UnimplementedError();
  }

  @override
  Future put(String url, {required body, Map<String, String>? headers}) {
    // TODO: implement put
    throw UnimplementedError();
  }
}
