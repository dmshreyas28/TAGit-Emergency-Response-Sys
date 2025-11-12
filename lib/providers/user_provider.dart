import 'package:flutter/foundation.dart';
import '../models/user_profile.dart';

class UserProvider with ChangeNotifier {
  UserProfile? _userProfile;
  bool _isLoading = false;
  String? _error;

  UserProfile? get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _userProfile != null;

  void setUserProfile(UserProfile? profile) {
    _userProfile = profile;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setError(String? error) {
    _error = error;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void logout() {
    _userProfile = null;
    _error = null;
    notifyListeners();
  }
}
