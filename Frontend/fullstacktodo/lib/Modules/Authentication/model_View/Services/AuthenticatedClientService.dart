import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fullstacktodo/Modules/Authentication/data/Model/TokenModel.dart';
import 'package:fullstacktodo/Modules/Authentication/data/Model/UserResponseDTO.dart';
import 'package:fullstacktodo/Modules/Authentication/data/repo/authRepo.dart';
import 'package:fullstacktodo/Modules/Authentication/model_View/Services/StorageService.dart';
import 'package:fullstacktodo/secrets/key.dart';
import 'package:fullstacktodo/utils/authException.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthenticatedClientService extends http.BaseClient {
  final storage = Storageservice();
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    String? acessToken = await storage.getAcessToken();

    if (acessToken != null && JwtDecoder.isExpired(acessToken)) {
      /// Request for new Request token---
      await tokenRequest();
      acessToken = await storage.getAcessToken();
    }

    request.headers['Authorization'] = 'Bearer $acessToken';

    request.headers['Content-Type'] = 'application/json';
    debugPrint(
      "--------------------${request.headers.toString()},${request.method},${request.url}",
    );

    // send the request
    http.StreamedResponse response = await _inner.send(request);

    return response;
  }

  Future<bool> hasToken() async {
    return await storage.getAcessToken() != null;
  }

  Future<String?> getAcessToken() async {
    final String? at = await storage.getAcessToken();
    return at;
  }

  Future<void> tokenRequest() async {
    String baseUrl = "http://$secretskey:8080/auth";
    try {
      final refreshToken = await storage.getRefreshToken();
      debugPrint(refreshToken);
      if (refreshToken == null) {
        throw Exception("REFRESH TOKEN IS NULL");
      }
      final Map<String, dynamic> bodyData = {'refreshToken': refreshToken};
      final response = await _inner.post(
        Uri.parse("$baseUrl/refresh"),
        body: jsonEncode(refreshToken),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        debugPrint(response.body);
        debugPrint("Done.");
        final newToken = Tokenmodel.formJson(jsonDecode(response.body));
        await storage.saveToken(newToken.accessToken, newToken.refreshToken);
      } else {
        AuthException authException = AuthException.fromJson(
          jsonDecode(response.body),
        );
        throw authException;
      }
    } catch (e) {
      rethrow;
    }
  }
}
