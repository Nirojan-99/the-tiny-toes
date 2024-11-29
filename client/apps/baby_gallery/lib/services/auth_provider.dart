import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final String _username = 'user';
  final String _password = 'password123';
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  String? validateLogin(String username, String password) {
    if (username == _username && password == _password) {
      _isLoggedIn = true;
      notifyListeners();
      return null;
    } else {
      return 'Invalid username or password';
    }
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
