import 'package:baby_gallery/services/network_service.dart';
import 'package:flutter/material.dart';

class AlbumsProvider with ChangeNotifier {
  final NetworkService _networkService = NetworkService();
  List<dynamic> _albums = [];
  bool _isLoading = false;
  String? _error;

  List<dynamic> get albums => _albums;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchAlbums(userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _albums = await _networkService.fetchData(
          'https://jsonplaceholder.typicode.com/albums?userId=$userId');
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
