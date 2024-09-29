import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_admin/constants/bottom_page.dart';
import 'package:sms_admin/constants/error_handling.dart';
import 'package:sms_admin/constants/global.dart';
import 'package:sms_admin/feat/auth/screens/auth-screen.dart';
import 'package:sms_admin/models/user.dart';
import 'package:sms_admin/user_provider.dart';

class AuthService {
  // Sign up user
  Future<void> signUpUser({
    required BuildContext context,
    required String name,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        role: '',
        token: '',
      );
      // print(user);
      // print(user.name);
      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
        // print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
              context, 'Account created! Login with the same credentials.');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Sign in user
  Future<void> signInUser({
    required BuildContext context,
    required String name,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/signin'),
        body: jsonEncode({
          'name': name,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
           print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);

          // Navigate to the BottomBarScreen after successful login
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomBar.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Check token validity
  Future<bool> checkTokenValidity(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null || token.isEmpty) {
        return false;
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        // If token is valid, fetch user data
        await fetchUserData(context);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      showSnackBar(context, e.toString());
      return false;
    }
  }

  // Fetch user data
  Future<void> fetchUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null || token.isEmpty) {
        return;
      }

      http.Response userRes = await http.get(
        Uri.parse('$uri/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      var userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setUser(userRes.body);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Log out user
  Future<void> logOut(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('x-auth-token', '');

      // Navigate back to the AuthScreen after logout
      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
