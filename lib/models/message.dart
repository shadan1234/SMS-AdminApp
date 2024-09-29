class Message {
  final String message;
  final String name;
  final DateTime timestamp;

  Message({required this.message, required this.name, required this.timestamp});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json['message'],
      name: json['name'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}