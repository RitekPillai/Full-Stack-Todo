class AuthException implements Exception {
  String timeStamp;
  String StatusCode;
  String errorMessage;

  AuthException({
    required this.StatusCode,
    required this.errorMessage,
    required this.timeStamp,
  });

  factory AuthException.fromJson(Map<String, dynamic> json) {
    return AuthException(
      StatusCode: json['statusCode'],
      errorMessage: json['error'],
      timeStamp: json['timeStamp'],
    );
  }
}
