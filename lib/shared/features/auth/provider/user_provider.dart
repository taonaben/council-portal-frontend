// filepath: c:\Users\taona\Documents\my work\city_council_portal\frontend\portal\lib\providers\user_provider.dart
import 'package:flutter/material.dart';
import 'package:portal/shared/features/auth/model/user_model.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}