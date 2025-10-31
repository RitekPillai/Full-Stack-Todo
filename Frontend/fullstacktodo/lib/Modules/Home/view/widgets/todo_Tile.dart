import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fullstacktodo/Modules/Home/data/model/Todo.dart';

import 'package:fullstacktodo/Modules/Home/model_View/bloc/todo_bloc.dart';
import 'package:fullstacktodo/Modules/Home/view/Pages/todoCreate.dart';
import 'package:fullstacktodo/Modules/Home/view/Pages/updateTodo.dart';
import 'package:intl/intl.dart';

String dateCheck(DateTime date) {
  DateTime dateTime = DateTime.now();
  if (date.day == dateTime.day &&
      date.month == dateTime.month &&
      date.year == dateTime.year) {
    return "Today";
  } else if (date.day == dateTime.day - 1 &&
      date.month == dateTime.month - 1 &&
      date.hour == dateTime.year - 1) {
    return "Yesterday";
  }
  return DateFormat.MMMMd().format(date);
  ;
}

Widget todoTile(Todo todo, BuildContext context, int? index) {
  return GestureDetector(
    onDoubleTap: () => {
      context.read<TodoBloc>().add(DeleteTodoEvent(todo.id!)),
      if (index == 0) {Navigator.pop(context)},
    },
    child: Padding(
      padding: const EdgeInsets.only(left: 15.0, top: 15, bottom: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xfff4f7ff).withAlpha(100),
          borderRadius: BorderRadius.circular(35),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 75,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),

                    child: Checkbox(
                      shape: const CircleBorder(
                        side: BorderSide(color: Colors.black),
                      ),
                      value: todo.isCompleted,

                      onChanged: (bool? newValue) {
                        if (newValue != null) {
                          todo.isCompleted = newValue;

                          BlocProvider.of<TodoBloc>(
                            context,
                          ).add(UpdateTodoEvent(todo));
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_month_rounded, size: 29),
                          Text(
                            dateCheck(todo.dueDate!),
                            style: TextStyle(fontSize: 17),
                          ),
                          const SizedBox(width: 25),
                          Icon(Icons.timelapse_rounded, size: 29),
                          Text(
                            "${todo.dueTime!.hour.toString()}:${todo.dueTime!.minute.toString()}",
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(todo.name, style: TextStyle(fontSize: 25)),
                      const SizedBox(height: 5),
                      Text(todo.description, style: TextStyle(fontSize: 20)),
                    ],
                  ),
                  const SizedBox(width: 23),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Todocreate(index: 1, todo: todo),
                        ),
                      );
                    },
                    icon: Icon(Icons.more_horiz_sharp),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

_showDialog(context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(actions: [Text("test")]);
    },
  );
}
