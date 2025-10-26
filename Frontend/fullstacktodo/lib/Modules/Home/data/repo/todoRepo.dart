import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fullstacktodo/Modules/Home/data/model/SubTask.dart';
import 'package:fullstacktodo/Modules/Home/data/model/status.dart';
import 'package:http/http.dart' as http;
import 'package:fullstacktodo/Modules/Home/data/model/Todo.dart';

class Todorepo {
  final String baseUrl = 'http://localhost:8080/';

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
}
