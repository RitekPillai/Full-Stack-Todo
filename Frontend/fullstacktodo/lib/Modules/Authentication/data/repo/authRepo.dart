import 'dart:convert';

import 'package:fullstacktodo/Modules/Authentication/data/Model/TokenModel.dart';
import 'package:fullstacktodo/Modules/Authentication/data/Model/UserResponseDTO.dart';
import 'package:fullstacktodo/Modules/Authentication/data/Model/user.dart';
import 'package:fullstacktodo/Modules/Authentication/model_View/Services/AuthenticatedClientService.dart';
import 'package:fullstacktodo/Modules/Authentication/model_View/Services/StorageService.dart';
import 'package:fullstacktodo/secrets/key.dart';
import 'package:fullstacktodo/utils/authException.dart';
import 'package:http/http.dart' as http;

class Authrepo {
  final String baseUrl = "http://$secretskey:8080/auth";
  final Storageservice storage = Storageservice();
  final AuthenticatedClientService authenticatedClient =
      AuthenticatedClientService();

  Future<Userresponsedto> login(User user) async {
    final Map<String, dynamic> payload = user.toJson();

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login"),
        body: jsonEncode(payload),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Tokenmodel tokens = Tokenmodel.formJson(
          jsonDecode(response.body),
        );

        await storage.saveToken(tokens.accessToken, tokens.refreshToken);

        return await getAuthenticatedUser();
      } else {
        AuthException exception = AuthException.fromJson(
          jsonDecode(response.body),
        );
        throw AuthException(
          StatusCode: exception.StatusCode,
          errorMessage: exception.errorMessage,
          timeStamp: exception.timeStamp,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Userresponsedto> SignUp(User user) async {
    Map<String, dynamic> payload = user.toJson();
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/signup"),
        body: jsonEncode(payload),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Userresponsedto userresponsedto = Userresponsedto.fromJson(
          jsonDecode(response.body),
        );

        return userresponsedto;
      } else {
        AuthException exception = AuthException.fromJson(
          jsonDecode(response.body),
        );
        throw AuthException(
          StatusCode: exception.StatusCode,
          errorMessage: exception.errorMessage,
          timeStamp: exception.timeStamp,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await storage.clearAll();
  }

  Future<Userresponsedto> getAuthenticatedUser() async {
    final response = await authenticatedClient.get(Uri.parse("$baseUrl/user"));
    try {
      if (response.statusCode == 200) {
        Userresponsedto user = Userresponsedto.fromJson(
          jsonDecode(response.body),
        );

        return user;
      } else {
        AuthException exception = AuthException.fromJson(
          jsonDecode(response.body),
        );
        throw AuthException(
          StatusCode: exception.StatusCode,
          errorMessage: exception.errorMessage,
          timeStamp: exception.timeStamp,
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
