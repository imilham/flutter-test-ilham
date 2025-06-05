import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/user.dart';

// Handles all API interactions for user data
class UserRepository {
  final http.Client _client;
  // Using JSONPlaceholder API for demo data
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
//
  UserRepository({http.Client? client}) : _client = client ?? http.Client();

  // Fetches user data from the API for a given user ID
  Future<User> getUser(String userId) async {
    try {
      final response = await _client.get(Uri.parse('$_baseUrl/users/$userId'));//

      if (response.statusCode == 200) {
        // Parse JSON response into a User object
        return User.fromJson(jsonDecode(response.body));
      } else {
        /// Handle HTTP errors [like 404, 500, etc.]
        throw HttpException('Failed to load user data. Status Code: ${response.statusCode}');//
      }
    } on HttpException {
      /// Re-throw HTTP errors as they're already formatted
      rethrow;
    } catch (e) {
      /// Wrap other errors [JSON parsing, network issues, etc.]
      throw Exception('An error occurred while fetching user data: $e');
    }
  }

  // Clean up HTTP client when repository is disposed
  void dispose() {
    _client.close();
  }
}
