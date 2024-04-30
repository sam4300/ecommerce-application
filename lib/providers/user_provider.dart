import 'package:ecommerce_application/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: '',
      password: '',
      email: '',
      name: '',
      address: '',
      type: '',
      token: '');

  User get user => _user;

  void updataUser(String res) {
    _user = User.fromJson(res);
    notifyListeners();
  }
}
