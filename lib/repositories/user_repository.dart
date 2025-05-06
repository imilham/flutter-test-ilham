import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserRepository {
  final http.Client _client;
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  UserRepository({http.Client? client}) : _client = client ?? http.Client();

  Future<User> getUser(String userId) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/users/$userId'),
      );

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        throw HttpException('Failed to load user data. Status Code: ${response.statusCode}');
      }
    } on HttpException {
      rethrow;
    } catch (e) {
      throw Exception('An error occurred while fetching user data: $e');
    }
  }

  void dispose() {
    _client.close();
  }
}
