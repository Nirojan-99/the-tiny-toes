import 'package:baby_gallery/services/storage_service.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final String _username = 'user';
  final String _password = 'password123';

  bool _isLoggedIn = false;
  final StorageService _storageService = StorageService();
  bool get isLoggedIn => _isLoggedIn;

  Future<bool?> validateLogin(String username, String password) async {
    if (username == _username && password == _password) {
      _isLoggedIn = true;
      await _storageService.storeUsername(username);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkLoginStatus() async {
    final username = await _storageService.getUsername();
    return username.isNotEmpty;//bug fixed
  }

  Future<void> logout(BuildContext context) async {
    _isLoggedIn = false;
    await _storageService.clearStorage();
    Navigator.pushReplacementNamed(context, '/login');
    notifyListeners();
  }
}
