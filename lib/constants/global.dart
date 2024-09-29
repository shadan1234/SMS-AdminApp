
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

String uri = 'https://sms-admin-app.vercel.app';
class GlobalVariables{

}