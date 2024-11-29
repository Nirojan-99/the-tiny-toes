import 'package:baby_gallery/services/network_service.dart';
import 'package:flutter/material.dart';

class UsersProvider with ChangeNotifier {
  final NetworkService _networkService = NetworkService();
  List<dynamic> _users = [];
  bool _isLoading = false;
  String? _error;

  List<dynamic> get users => _users;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      _users = await _networkService
          .fetchData('https://jsonplaceholder.typicode.com/users');
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
