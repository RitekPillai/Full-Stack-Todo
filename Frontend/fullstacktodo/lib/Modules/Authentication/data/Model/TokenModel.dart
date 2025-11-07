import 'package:equatable/equatable.dart';

class Tokenmodel extends Equatable {
  final String refreshToken;
  final String accessToken;
  final int userid;

  const Tokenmodel({
    required this.refreshToken,
    required this.accessToken,
    required this.userid,
  });

  factory Tokenmodel.formJson(Map<String, dynamic> json) {
    return Tokenmodel(
      userid: json['id'],
      refreshToken: json['refreshToken'],
      accessToken: json['accessToken'],
    );
  }
  @override
  List<Object> get props => [accessToken, refreshToken];
}
