import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:sms_admin/constants/global.dart';
import 'package:sms_admin/user_provider.dart';

class MessageService {
  // final String mongoDbUri = 'your_mongodb_uri'; // Replace with your MongoDB URI
  // final String smsApiUrl = 'your_sms_api_url'; // Replace with your SMS API URL
  // final String smsApiKey = 'your_sms_api_key'; // Replace with your SMS API Key

  Future<void> sendMessage(String message,BuildContext context) async {
    // Send message to MongoDB
    await _sendToMongoDB(message,context);

    // Send SMS to all users
    await _sendSmsToAllUsers(message);
  }

  Future<void> _sendToMongoDB(String message,BuildContext context) async {
   final user=Provider.of<UserProvider>(context,listen: false).user;
    try {
      final response = await http.post(
        Uri.parse('$uri/messages'), // Adjust the endpoint according to your server configuration
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'message': message,
          'name' : user.name,
          'timestamp': DateTime.now().toIso8601String(),
          // Add other necessary fields here (e.g., user ID, user name)
        }),
      );
     print(response.body);
      if (response.statusCode == 200) {
        print('Message sent to MongoDB successfully.');
      } else {
        print('Failed to send message to MongoDB. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending message to MongoDB: $e');
    }
  }

 Future<void> _sendSmsToAllUsers(String message) async {
    try {
      // Fetch all user phone numbers from MongoDB or another source
      List<String> phoneNumbers = await _fetchPhoneNumbers();

      // Using flutter_sms package to send SMS
      String result = await sendSMS(
        message: message,
        recipients: phoneNumbers,
        sendDirect: true, // Set to true to send directly or false to let users confirm the SMS
      );

      print(result);
    } catch (e) {
      print('Error sending SMS: $e');
    }
  }

  Future<List<String>> _fetchPhoneNumbers() async {
    // Replace this method with actual code to fetch phone numbers from MongoDB
    // For demonstration purposes, returning a dummy list of phone numbers
    return ['+919032044420', ];
  }
}
