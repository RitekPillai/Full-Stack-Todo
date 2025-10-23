import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstacktodo/Modules/Home/data/model/Todo.dart';
import 'package:fullstacktodo/Modules/Home/data/model/status.dart';
import 'package:fullstacktodo/Modules/Home/model_View/bloc/todo_bloc.dart';
import 'package:fullstacktodo/Modules/Home/view/widgets/status_Template.dart';
import 'package:fullstacktodo/Modules/Home/view/widgets/todo_Tile.dart';

class Hompage extends StatelessWidget {
  const Hompage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isToday(DateTime? date) {
      final now = DateTime.now();
      return date!.year == now.year &&
          date.month == now.month &&
          date.day == now.day;
    }

    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoaded) {
            int todoCount = 0;
            int inProgressCount = 0;
            int completedCount = 0;
            int onHoldCount = 0;
            int droppedCount = 0;

            List<Todo> todayTask = [];

            for (var todo in state.todo) {
              if (isToday(todo.dueDate)) {
                todayTask.add(todo);
              }

              if (todo.subTask == Status.notstarted) {
                todoCount++;
              } else if (todo.subTask == Status.inprogress) {
                inProgressCount++;
              } else if (todo.subTask == Status.completed) {
                completedCount++;
              } else if (todo.subTask == Status.onhold) {
                onHoldCount++;
              } else if (todo.subTask == Status.dropped) {
                droppedCount++;
              }
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          status_Template(
                            Icons.book,
                            "Todo",
                            todoCount,
                            0xfffff580,
                          ),
                          status_Template(
                            Icons.timer,
                            "Inprogress",
                            inProgressCount,
                            0xffb4c4fe,
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          status_Template(
                            Icons.timer,
                            "Completed",
                            completedCount,
                            0xffd0f4ea,
                          ),
                          status_Template(
                            Icons.timer,
                            "onhold",
                            onHoldCount,
                            0xfffeb269,
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          status_Template(
                            Icons.timer,
                            "Dropped",
                            droppedCount,
                            0xffff6969,
                          ),
                          status_Template(
                            Icons.timer,
                            "All Task",
                            state.todo.length,
                            0xffec69ff,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Today's Task", style: TextStyle(fontSize: 23)),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: todayTask.length,
                    itemBuilder: (context, index) {
                      final task = todayTask[index];

                      return todoTile(
                        task.name,
                        task.description,
                        task.isCompleted,
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is TodoLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Container();
        },
      ),
    );
  }
}
