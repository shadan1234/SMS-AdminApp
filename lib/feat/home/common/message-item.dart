import 'package:flutter/material.dart';
import 'package:sms_admin/models/message.dart';

class MessageItem extends StatelessWidget {
  final Message message;

  const MessageItem({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSender = message.name == "You"; // Change this condition based on your logic

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
                Text(
                  message.name ?? 'Unknown User',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isSender ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  message.message ?? '',
                  style: TextStyle(color: isSender ? Colors.white : Colors.black),
                ),
                const SizedBox(height: 5),
                Text(
                  message.timestamp?.toString() ?? '',
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
}
