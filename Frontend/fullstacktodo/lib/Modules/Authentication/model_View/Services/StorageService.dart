import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storageservice {
  final storage = const FlutterSecureStorage();
  final String _acessToken = "acessToken";
  final String _refreshToken = "refreshToken";

  Future<void> saveToken(String acessToken, String refreshToken) async {
    await storage.write(key: _acessToken, value: acessToken);
    await storage.write(key: _refreshToken, value: refreshToken);
  }

  Future<String?> getAcessToken() async {
    return storage.read(key: _acessToken);
  }

  Future<String?> getRefreshToken() async {
    return storage.read(key: _refreshToken);
  }

  Future<void> clearAll() async {
    await storage.delete(key: _acessToken);
    await storage.delete(key: _refreshToken);
  }
}
