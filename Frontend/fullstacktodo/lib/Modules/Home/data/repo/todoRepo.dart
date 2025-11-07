import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fullstacktodo/Modules/Authentication/model_View/Services/AuthenticatedClientService.dart';
import 'package:fullstacktodo/secrets/key.dart';
import 'package:fullstacktodo/utils/authException.dart';
import 'package:fullstacktodo/Modules/Home/data/model/Todo.dart';

class Todorepo {
  final String baseUrl = 'http://$secretskey:8080/todo';
  final AuthenticatedClientService _authenticatedClientService =
      AuthenticatedClientService();

  Future<List<Todo>> fetchTodo() async {
    final response = await _authenticatedClientService.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      try {
        final List<dynamic> todoJsonList = json.decode(response.body);

        return todoJsonList.map((json) => Todo.fromJson(json)).toList();
      } catch (e) {
        rethrow;
      }
    } else {
      throw AuthException.fromJson(jsonDecode(response.body));
    }
  }

  Future<Todo> createTodo(Todo todo) async {
    final Map<String, dynamic> payload = todo.toJson();

    debugPrint('Sending Payload: ${jsonEncode(payload)}');

    final response = await _authenticatedClientService.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      try {
        return Todo.fromJson(json.decode(response.body));
      } catch (e) {
        rethrow;
      }
    } else {
      throw AuthException.fromJson(jsonDecode(response.body));
    }
  }

  Future<Todo> updateTodo(Todo todo) async {
    final Map<String, dynamic> payload = todo.toJson();
    final int id = todo.id!;

    final response = await _authenticatedClientService.put(
      Uri.parse("$baseUrl?id=$id"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return todo;
    } else {
      // Failure path (4xx/5xx)
      throw Exception(
        'Server update failed. Status: ${response.statusCode}. Details: ${response.body}',
      );
    }
  }

  Future<void> deleteTodo(int id) async {
    try {
      final response = await _authenticatedClientService.delete(
        Uri.parse("$baseUrl?id=$id"),
      );

      if (response.statusCode == 200) {
        debugPrint("---------------------Deleted-------------------------");
      } else {
        throw Exception();
      }
    } catch (e) {
      debugPrint(
        "---------------------${e.toString()}-------------------------",
      );
    }
  }
}
