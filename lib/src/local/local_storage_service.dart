import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _errorMessage = 'Failed to get value from local storage';

class LocalStorageService {
  static const _storage = FlutterSecureStorage();

  static Future<void> saveLoginDetails({
    required String email,
    required String userName,
  }) async {
    try {
      await Future.wait([
        _storage.write(key: AppConstants.emailPref, value: email),
        _storage.write(key: AppConstants.userNamePref, value: userName),
      ]);
    } on Error {
      throw Failure(_errorMessage);
    } on Exception {
      throw Failure(_errorMessage);
    }
  }

  static Future<String?> getEmail() async {
    try {
      final value = await _storage.read(key: AppConstants.emailPref);
      return value;
    } on Error {
      throw Failure(_errorMessage);
    } on Exception {
      throw Failure(_errorMessage);
    }
  }

  static Future<String?> getUserName() async {
    try {
      final value = await _storage.read(key: AppConstants.userNamePref);
      return value;
    } on Error {
      throw Failure(_errorMessage);
    } on Exception {
      throw Failure(_errorMessage);
    }
  }

  static clear() async {
    await _storage.deleteAll();
  }

  // static Future<void> saveFingerprintPref({
  //   required bool wantFingerPrint,
  // }) async {
  //   await _storage.write(
  //     key: AppConstants.fingerPrintPref,
  //     value: wantFingerPrint.toString(),
  //   );
  // }

  // static Future<bool?> getFingerprintPref() async {
  //   final value = await _storage.read(key: AppConstants.fingerPrintPref);

  //   if (value != null) {
  //     if (value == true.toString()) {
  //       return true;
  //     }

  //     if (value == false.toString()) {
  //       return false;
  //     }
  //   }
  //   return null;
  // }
}
