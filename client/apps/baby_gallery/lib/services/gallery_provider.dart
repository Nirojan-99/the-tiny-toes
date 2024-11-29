import 'package:baby_gallery/services/network_service.dart';
import 'package:flutter/material.dart';

class GalleryProvider with ChangeNotifier {
  final NetworkService _networkService = NetworkService();
  List<dynamic> _gallery = [];
  bool _isLoading = false;
  String? _error;

  List<dynamic> get gallery => _gallery;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchGalleries(albumId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _gallery = await _networkService.fetchData(
          'https://jsonplaceholder.typicode.com/photos?albumId=$albumId');
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}