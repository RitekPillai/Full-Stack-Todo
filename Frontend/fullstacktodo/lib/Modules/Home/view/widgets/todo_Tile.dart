import 'package:flutter/material.dart';
import 'package:fullstacktodo/Modules/Home/data/model/SubTask.dart';

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
  return "No Date";
}

Widget todoTile(
  String name,
  String Description,
  bool isCompleted,
  DateTime? dueDate,
  DateTime? dueTime,
  List<SubTasks>? subtask,
) {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0, top: 15, bottom: 15),
    child: Container(
      height: 150,

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
                    shape: CircleBorder(side: BorderSide(color: Colors.black)),
                    value: isCompleted,

                    onChanged: (value) {
                      value = true;
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
                          dateCheck(dueDate!),
                          style: TextStyle(fontSize: 17),
                        ),
                        const SizedBox(width: 25),
                        Icon(Icons.timelapse_rounded, size: 29),
                        Text(
                          "${dueTime!.hour.toString()}:${dueTime.minute.toString()}",
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(name, style: TextStyle(fontSize: 25)),
                    const SizedBox(height: 5),
                    Text(Description, style: TextStyle(fontSize: 17)),
                  ],
                ),
                const SizedBox(width: 23),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_horiz_sharp),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget SubTaskTile(String title, bool isComplete) {
  return Row(
    children: [
      Checkbox(value: isComplete, onChanged: (value) {}),
      Text(title),
    ],
  );
}
