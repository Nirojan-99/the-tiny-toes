import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkService {
  Future<dynamic> fetchData(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}