import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importing intl package for date formatting
import 'package:provider/provider.dart';
import 'package:sms_admin/models/message.dart';
import 'package:sms_admin/user_provider.dart';

class MessageItem extends StatelessWidget {
  final Message message;

  const MessageItem({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   final userProvider = Provider.of<UserProvider>(context, listen: false);
    final isSender = message.name == userProvider.user.name; // Change this condition based on your logic

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isSender ? Colors.blue : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sender's name
                Text(
                  message.name ?? 'Unknown User',
                  style: TextStyle(
                    fontSize: 12, // Smaller font size for name
                    fontWeight: FontWeight.bold,
                    color: isSender ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                // Main message
                Text(
                  message.message ?? '',
                  style: TextStyle(
                    fontSize: 16, // Larger font size for the main message
                    color: isSender ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                // Formatted timestamp
                Text(
                  _formatTimestamp(message.timestamp),
                  style: TextStyle(
                    color: isSender ? Colors.white70 : Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to format the timestamp
  String _formatTimestamp(DateTime? timestamp) {
    if (timestamp == null) return '';
    return DateFormat('yyyy-MM-dd – kk:mm').format(timestamp); // Format: YYYY-MM-DD - HH:MM
  }
}
