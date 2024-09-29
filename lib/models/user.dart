// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
    final String id;
  final String name;
 
  final String password;
  final String role;
  final String token;

  User({required this.id, required this.name, required this.password, required this.role, required this.token});


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'password': password,
      'role': role,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      password: map['password'] as String,
      role: map['role'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  User copyWith({
    String? id,
    String? name,
    String? password,
    String? role,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      password: password ?? this.password,
      role: role ?? this.role,
      token: token ?? this.token,
    );
  }
}
