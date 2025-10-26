import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstacktodo/Modules/Home/data/model/Todo.dart';
import 'package:fullstacktodo/Modules/Home/model_View/bloc/todo_bloc.dart';
import 'package:fullstacktodo/Modules/Home/view/widgets/todo_Tile.dart';

class Alltask extends StatelessWidget {
  final int color;
  final List<Todo> todo;
  const Alltask({required this.color, required this.todo, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(color),
          body: ListView.builder(
            itemCount: todo.length,
            itemBuilder: (context, index) => todoTile(
              todo[index].name,
              todo[index].description,
              todo[index].isCompleted,
              todo[index].dueDate,
              todo[index].dueTime,
              todo[index].subTask,
            ),
          ),
        );
      },
    );
  }
}
