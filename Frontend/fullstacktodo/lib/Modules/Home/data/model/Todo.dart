import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int id;
  final String name;
  final String description;
  final bool isCompleted;
  final DateTime creationDate;

  const Todo({
    required this.id,
    required this.name,
    required this.description,
    required this.isCompleted,
    required this.creationDate,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      isCompleted: json['isCompleted'] as bool,
      creationDate: DateTime.parse(json['creationDate'] as String),
    );
  }

  @override
  List<Object?> get props => [id, name, description, isCompleted, creationDate];
}
