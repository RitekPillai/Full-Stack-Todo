import 'dart:convert';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:fullstacktodo/Modules/Home/data/model/Todo.dart';

class Todorepo {
  final String baseUrl = 'http://localhost:8080';

  Future<List<Todo>> fetchTodo() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      try {
        final List<dynamic> todoJsonList = json.decode(response.body);

        return todoJsonList.map((json) => Todo.fromJson(json)).toList();
      } catch (e) {
        throw Exception('Failed to parse todo data: $e');
      }
    } else {
      throw Exception(
        'Failed to load todos. Status code: ${response.statusCode}',
      );
    }
  }

  Future<Todo> createTodo(Todo todo) async {
    final Map<String, dynamic> payload = todo.toJson();

    debugPrint('Sending Payload: ${jsonEncode(payload)}');

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      try {
        return Todo.fromJson(json.decode(response.body));
      } catch (e) {
        throw Exception('Todo created but failed to parse response: $e');
      }
    } else {
      throw Exception(
        'Failed to create todo. Status: ${response.statusCode}. Response: ${response.body}',
      );
    }
  }

  Future<Todo> updateTodo(Todo todo) async {
    final Map<String, dynamic> payload = todo.toJson();
    final int id = todo.id!;

    final response = await http.put(
      // ⚠️ Recommended change: Use path parameter for REST standard, though query works if the server is configured for it.
      // Uri.parse("$baseUrl/$id"),
      Uri.parse("$baseUrl?id=$id"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );

    // Check for successful status codes (200-299)
    if (response.statusCode >= 200 && response.statusCode < 300) {
      // ✅ FINAL FIX: If status is success, bypass parsing the bad body
      // and return the original Todo object (which contains the updated status/data).
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
      final response = await http.delete(Uri.parse("$baseUrl?id=$id"));

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
