import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:flutter/cupertino.dart';

class BaseController extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Failure? _failure;
  Failure? get failure => _failure;
  setFailure(Failure error) {
    _failure = error;
  }
}
