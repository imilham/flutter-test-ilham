import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

// Different states a user can be in
enum UserStatus { initial, loading, success, error }

// Manages user data and loading states throughout the app
class UserProvider extends ChangeNotifier {
  final UserRepository _repository;
  
  // Internal state
  User? _user;                                    // Current user data
  UserStatus _status = UserStatus.initial;        // Loading status
  String? _error;                                 // Error message if any

  UserProvider({required UserRepository repository}) : _repository = repository;

  User? get user => _user;
  UserStatus get status => _status;
  String? get error => _error;
  bool get isLoading => _status == UserStatus.loading;

  // Fetches user data from the repository
  Future<void> fetchUser(String userId) async {
    // Start loading and clear any previous errors
    _status = UserStatus.loading;
    _error = null;
    notifyListeners();  // Tell widgets to show loading state

    try {
      _user = await _repository.getUser(userId);
      _status = UserStatus.success;
    } catch (e) {
      _error = e.toString();
      _status = UserStatus.error;
    }
    
    notifyListeners();
  }

  @override
  void dispose() {
    // Clean up when provider is removed
    _repository.dispose();
    super.dispose();
  }
}
