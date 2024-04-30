import 'dart:convert';

import 'package:ecommerce_application/common/utils.dart';
import 'package:ecommerce_application/constants/error_handling.dart';
import 'package:ecommerce_application/constants/global_variables.dart';
import 'package:ecommerce_application/features/auth/screens/home_screen.dart';
import 'package:ecommerce_application/models/user.dart';
import 'package:ecommerce_application/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpUser({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      User user = User(
        id: '',
        password: password,
        email: email,
        name: name,
        address: '',
        type: '',
        token: '',
      );
      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (!context.mounted) return;

      httpErrorHandle(
        res: res,
        context: context,
        onSuccess: () {
          showSnackBar(
              context, 'Account created Login with the same credentials!');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    if (!context.mounted) return;
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode(
          {
            'email': email,
            'password': password,
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (!context.mounted) return;

      httpErrorHandle(
        context: context,
        res: res,
        onSuccess: () async {
          final pref = await SharedPreferences.getInstance();
          if (!context.mounted) return;

          Provider.of<UserProvider>(context, listen: false)
              .updataUser(res.body);

          await pref.setString('auth-token', jsonDecode(res.body)['token']);
          if (!context.mounted) return;

          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.route, (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth-token');
      if (token == null) {
        prefs.setString('auth-token', '');
      }

      var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "auth-token": token!
          });

      var res = jsonDecode(tokenRes.body);
      if (res == true) {
        http.Response userResponse =
            await http.get(Uri.parse('$uri/'), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "auth-token": token,
        });
        if (!context.mounted) return;
        Provider.of<UserProvider>(context, listen: false)
            .updataUser(userResponse.body);
      }
    } catch (e) {
      if (!context.mounted) return;
      showSnackBar(context, e.toString());
    }
  }
}
