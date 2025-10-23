import 'package:equatable/equatable.dart';
import 'package:fullstacktodo/Modules/Home/data/model/SubTask.dart';
import 'package:fullstacktodo/Modules/Home/data/model/status.dart';

class Todo extends Equatable {
  final int id;
  final String name;
  final bool isCompleted;
  final DateTime? creationDate;
  final DateTime? dueDate;
  final Status taskStatus;
  final String description;
  final List<SubTasks> subTask;
  final DateTime? dueTime;

  const Todo({
    required this.dueDate,
    required this.taskStatus,
    required this.subTask,
    required this.id,
    required this.name,
    required this.description,
    required this.isCompleted,
    required this.creationDate,
    required this.dueTime,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    final String? statusString = json['status'] as String?;
    final Status status = Status.values.firstWhere(
      (e) =>
          e.toString().split('.').last.toUpperCase() ==
          statusString?.toUpperCase(),
      orElse: () => Status.inprogress,
    );

    final List<dynamic> subTaskJson = json['subTasks'] as List<dynamic>;
    final List<SubTasks> parsedTask = subTaskJson
        .map(
          (subTaskJson) =>
              SubTasks.fromJson(subTaskJson as Map<String, dynamic>),
        )
        .toList();
    return Todo(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      isCompleted: json['isCompleted'] as bool,
      creationDate: DateTime.parse(json['creationDate'] as String),
      dueDate: DateTime.parse(json['creationDate'] as String),
      dueTime: DateTime.parse(json['dueTime'] as String),
      taskStatus: status,
      subTask: parsedTask,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    isCompleted,
    creationDate,
    dueDate,
    dueTime,
    taskStatus,
    subTask,
  ];
}
