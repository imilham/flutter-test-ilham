import 'package:http/http.dart' as http;
import '../models/user.dart';

// TODO: Implement UserRepository
// Requirements:
// - Extract data fetching logic from UserProfileScreen
// - Implement a method to fetch user by ID
// - Return a User object instead of Map<String, dynamic>
// - Handle errors properly

class UserRepository {
  final http.Client _client;
  
  UserRepository({http.Client? client}) : _client = client ?? http.Client();
  
  // TODO: Implement getUser method
  Future<User> getUser(String userId) async {
    // TODO: Implement API call to fetch user data
    throw UnimplementedError('getUser has not been implemented');
  }
}
