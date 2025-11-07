import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String username;
  final String email;
  final String? password;
  const User({
    required this.password,
    required this.email,
    required this.username,
  });

  factory User.fromjson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      password: json['password'],
      username: json['username'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    return data;
  }

  @override
  List<Object> get props => [username, email, username];
}
