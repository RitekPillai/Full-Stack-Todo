import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstacktodo/Modules/Authentication/data/Model/UserResponseDTO.dart';
import 'package:fullstacktodo/Modules/Authentication/model_View/Bloc/bloc/auth_bloc.dart';
import 'package:fullstacktodo/Modules/Authentication/model_View/Services/UserService.dart';
import 'package:fullstacktodo/Modules/Home/data/model/Todo.dart';
import 'package:fullstacktodo/Modules/Home/data/model/status.dart';
import 'package:fullstacktodo/Modules/Home/model_View/bloc/todo_bloc.dart';
import 'package:fullstacktodo/Modules/Home/view/Pages/AllTask.dart';
import 'package:fullstacktodo/Modules/Home/view/Pages/todoCreate.dart';
import 'package:fullstacktodo/Modules/Home/view/widgets/status_Template.dart';
import 'package:fullstacktodo/Modules/Home/view/widgets/todo_Tile.dart';
import 'package:intl/intl.dart';

class Hompage extends StatelessWidget {
  const Hompage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isToday(DateTime date) {
      final todayDate = DateTime.now();
      bool isTodayTrue = false;
      if (date.month == todayDate.month &&
          date.year == todayDate.year &&
          date.day == todayDate.day) {
        isTodayTrue = true;
      } else {
        isTodayTrue = false;
      }
      return isTodayTrue;
    }

    return Scaffold(
      backgroundColor: Color(0xff998cff),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Color(0xff998cff),
        title: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {
                  if (state is TodoLoaded) {
                    return Text(
                      "Hello ${state.username}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  } else {
                    return Text(
                      "Hello user",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 5),
              Text("Here are your Task's"),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoaded) {
            int todoCount = 0;
            int inProgressCount = 0;
            int completedCount = 0;
            int onHoldCount = 0;
            int droppedCount = 0;

            List<Todo> todayTask = [];
            List<Todo> dropTask = [];
            List<Todo> todoTask = [];
            List<Todo> inProgressTask = [];
            List<Todo> compleleteTask = [];
            List<Todo> onHoldTask = [];

            for (var todo in state.todo) {
              if (isToday(todo.dueDate!)) {
                todayTask.add(todo);
              }

              if (todo.taskStatus == Status.NotStarted) {
                todoCount++;
                todoTask.add(todo);
              } else if (todo.taskStatus == Status.InProgress) {
                inProgressCount++;
                inProgressTask.add(todo);
              } else if (todo.taskStatus == Status.Completed) {
                completedCount++;
                compleleteTask.add(todo);
              } else if (todo.taskStatus == Status.OnHold) {
                onHoldCount++;
                onHoldTask.add(todo);
              } else if (todo.taskStatus == Status.Dropped) {
                droppedCount++;
                dropTask.add(todo);
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
                            context,
                            Alltask(color: 0xfffff580, todo: todoTask),
                            Offset(-1, 0),
                          ),
                          status_Template(
                            Icons.timer,
                            "Inprogress",
                            inProgressCount,
                            0xffb4c4fe,
                            context,
                            Alltask(color: 0xffb4c4fe, todo: inProgressTask),
                            Offset(1, 0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          status_Template(
                            Icons.done_all_rounded,
                            "Completed",
                            completedCount,
                            0xffd0f4ea,
                            context,
                            Alltask(color: 0xffd0f4ea, todo: compleleteTask),
                            Offset(-1, 0),
                          ),
                          status_Template(
                            Icons.pause,
                            "onhold",
                            onHoldCount,
                            0xfffeb269,
                            context,
                            Alltask(color: 0xfffeb269, todo: onHoldTask),
                            Offset(1, 0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          status_Template(
                            Icons.delete,
                            "Dropped",
                            droppedCount,
                            0xffff6969,
                            context,
                            Alltask(color: 0xffff6969, todo: dropTask),
                            Offset(0.0, 1.0),
                          ),
                          status_Template(
                            Icons.all_inbox_rounded,
                            "All Task",
                            state.todo.length,
                            0xffec69ff,

                            context,
                            Alltask(color: 0xffec69ff, todo: state.todo),
                            Offset(1.0, 0.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${DateFormat.EEEE().format(DateTime.now())}'s Task",
                    style: TextStyle(fontSize: 23, color: Colors.white),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: todayTask.length,
                    itemBuilder: (context, index) {
                      final task = todayTask[index];

                      return todoTile(todayTask[index], context, 1);
                    },
                  ),
                ),
              ],
            );
          } else if (state is TodoLoading) {
            return Center(child: Text("Yo"));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  Todocreate(index: 0),
              transitionDuration: Durations.medium4,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    const end = Offset.zero;
                    const curve = Curves.easeIn;
                    var tween = Tween(
                      begin: Offset(0, 1),
                      end: end,
                    ).chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
            ),
          );
        },
        child: Text("+", style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
    );
  }
}
