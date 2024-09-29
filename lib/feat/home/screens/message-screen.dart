import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_admin/feat/home/common/message-item.dart';
import 'package:sms_admin/feat/home/services/message-service.dart';
import 'package:sms_admin/models/message.dart';
import 'package:sms_admin/user_provider.dart';


class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController _messageController = TextEditingController();
  final MessageService _messageService = MessageService();
  List<Message> _messages = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    try {
      final messages = await _messageService.fetchMessages();
      // Sort messages by timestamp
      messages.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));
      setState(() {
        _messages = messages;
        _isLoading = false;
      });
      // print(messages);
      // print('bale');
      // for(int i=0;i<messages.length;i++){
      //   print(messages[i]);
      // }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Error loading messages: $e");
    }
  }

  Future<void> _sendMessage() async {
    String messageText = _messageController.text.trim();
    if (messageText.isEmpty) return;

    try {
      await _messageService.sendMessage(messageText, context);
      _messageController.clear();
      // Refresh message list after sending a message
      _loadMessages();
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _messages.isEmpty
                    ? Center(child: Text('No messages found.'))
                    : ListView.builder(
                        reverse: true, // Reverse scroll to show latest messages first
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final message = _messages[index];
                          return MessageItem(message: message); // Use the new MessageItem widget
                        },
                      ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
