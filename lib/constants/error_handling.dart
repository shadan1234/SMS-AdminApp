import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sms_admin/constants/global.dart';

void httpErrorHandle({required http.Response response,required BuildContext context,required VoidCallback onSuccess,}){
  switch(response.statusCode){
    case 200:
    onSuccess();
    break;
    case 400:
    showSnackBar(context, jsonDecode(response.body)['message']);
    break;
    case 500:
     showSnackBar(context, jsonDecode(response.body)['message']);
     break; 
     default:
     showSnackBar(context, response.body);
  }
}