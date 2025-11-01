import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstacktodo/Modules/Home/data/model/Todo.dart';
import 'package:fullstacktodo/Modules/Home/data/model/status.dart';
import 'package:fullstacktodo/Modules/Home/model_View/bloc/todo_bloc.dart';
import 'package:fullstacktodo/Modules/Home/view/widgets/todo_Tile.dart';

class Alltask extends StatelessWidget {
  final int color;
  final List<Todo> todo;

  const Alltask({required this.color, required this.todo, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(color)),
      backgroundColor: Color(color),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TodoLoaded) {
            if (todo.isEmpty) {
              return Center(
                child: Container(
                  height: 270,
                  width: 270,
                  decoration: BoxDecoration(
                    color: Color(0xfff4f7ff).withAlpha(200),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Image.asset(
                        "assets/images/no-task.png",
                        height: 170,
                        width: 170,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        "No Task Found",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: todo.length,
              itemBuilder: (context, index) =>
                  todoTile(todo[index], context, 0),
            );
          }
          return Container();
        },
      ),
    );
  }
}
