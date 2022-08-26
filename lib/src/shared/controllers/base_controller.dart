import 'package:flutter/cupertino.dart';

class BaseController extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isSearching = false;
  bool get isSearching => _isSearching;
  setIsSearching(bool value) {
    _isSearching = value;
    notifyListeners();
  }
}
