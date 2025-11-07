class Userresponsedto {
  String username;
  String email;

  Userresponsedto({required this.username, required this.email});

  factory Userresponsedto.fromJson(Map<String, dynamic> json) {
    return Userresponsedto(
      username: json['username'] as String,
      email: json['email'] as String,
    );
  }

  String getUsername() {
    return username;
  }
}
