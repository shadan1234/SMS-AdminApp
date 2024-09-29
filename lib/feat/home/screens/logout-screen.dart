import 'package:flutter/material.dart';
import 'package:sms_admin/feat/auth/services/auth_service.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            AuthService().logOut(context);
          },
          child: Text('Logout'),),
      ),
    );
  }
}