import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

// TODO: Implement UserProvider using ChangeNotifier
// Requirements:
// - Create a class that extends ChangeNotifier
// - Handle loading, success, and error states
// - Use UserRepository for data fetching
// - Notify listeners when state changes

enum UserState {
  initial,
  loading,
  success,
  error,
}

class UserProvider extends ChangeNotifier {
  final UserRepository _userRepository;
  
  // TODO: Add state variables
  UserState _state = UserState.initial;
  User? _user;
  String? _errorMessage;
  
  UserState get state => _state;
  User? get user => _user;
  String? get errorMessage => _errorMessage;
  
  UserProvider({UserRepository? userRepository}) 
      : _userRepository = userRepository ?? UserRepository();
  
  // TODO: Implement fetchUser method
  Future<void> fetchUser(String userId) async {
    // TODO: Implement state management for fetching user data
    // - Set loading state
    // - Call repository method
    // - Handle success and error cases
    // - Notify listeners
  }
}
