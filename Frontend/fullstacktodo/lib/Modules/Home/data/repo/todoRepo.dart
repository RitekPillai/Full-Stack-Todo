import 'dart:convert';
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
}
