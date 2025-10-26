import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fullstacktodo/Modules/Home/data/model/SubTask.dart';
import 'package:fullstacktodo/Modules/Home/data/model/status.dart';

class Todo extends Equatable {
  final int? id;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['name'] = name;
    data['isCompleted'] = isCompleted;

    data['creationDate'] = creationDate?.toIso8601String();
    data['dueDate'] = dueDate?.toIso8601String();
    data['dueTime'] = dueTime?.toIso8601String();

    data['subTasks'] = this.subTask.map((v) => v.toJson()).toList();

    data['taskStatus'] = this.taskStatus.name;
    data['description'] = this.description;

    return data;
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    final String? statusString = json['status'] as String?;
    final Status status = Status.values.firstWhere(
      (e) =>
          e.toString().split('.').last.toUpperCase() ==
          statusString?.toUpperCase(),
      orElse: () => Status.NotStarted,
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
      dueDate: DateTime.parse(json['dueDate'] as String),
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
