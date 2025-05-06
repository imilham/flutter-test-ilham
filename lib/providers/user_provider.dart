import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

enum UserStatus { initial, loading, success, error }

class UserProvider extends ChangeNotifier {
  final UserRepository _repository;
  
  User? _user;
  UserStatus _status = UserStatus.initial;
  String? _error;

  UserProvider({required UserRepository repository}) : _repository = repository;

  User? get user => _user;
  UserStatus get status => _status;
  String? get error => _error;
  bool get isLoading => _status == UserStatus.loading;

  Future<void> fetchUser(String userId) async {
    _status = UserStatus.loading;
    _error = null;
    notifyListeners();

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
    _repository.dispose();
    super.dispose();
  }
}
