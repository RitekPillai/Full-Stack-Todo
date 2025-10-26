import 'package:bottom_picker/bottom_picker.dart';
import 'package:drop_down_list/model/selected_list_item.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstacktodo/Modules/Home/data/model/SubTask.dart';
import 'package:fullstacktodo/Modules/Home/data/model/Todo.dart';
import 'package:fullstacktodo/Modules/Home/data/model/status.dart';
import 'package:fullstacktodo/Modules/Home/model_View/bloc/todo_bloc.dart';

import 'package:intl/intl.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:flutter/material.dart';

class Todocreate extends StatefulWidget {
  const Todocreate({super.key});

  @override
  State<Todocreate> createState() => _TodocreateState();
}

class _TodocreateState extends State<Todocreate> {
  Status currentStatus = Status.NotStarted;

  TimeOfDay _selectedTime = TimeOfDay.now(); // Initial time
  DateTime selectedDate = DateTime.now();
  TextEditingController checklistName = new TextEditingController();
  //VARIABLESSSSSSS

  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  List<SubTasks> checkListName = [];
  @override
  Widget build(BuildContext context) {
    String dateFormat(TimeOfDay date) {
      final localizations = MaterialLocalizations.of(context);
      final formattedTimeOfDay = localizations.formatTimeOfDay(date);

      return formattedTimeOfDay;
    }

    DateTime combineDateTimeAndTimeOfDay(DateTime date, TimeOfDay time) {
      return DateTime(date.year, date.month, date.day, time.hour, time.minute);
    }

    Future<void> selectTime() async {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: _selectedTime,
      );
      if (picked != null && picked != _selectedTime) {
        setState(() {
          _selectedTime = picked;
          dateFormat(_selectedTime);
        });
      }
    }

    void _showDialogBox(context, TextEditingController checklistcontroller) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("CheckList"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: CustomTile("Name:", checklistcontroller),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    fixedSize: WidgetStatePropertyAll(Size(150, 50)),
                  ),
                  onPressed: () {
                    if (checklistcontroller.text.isNotEmpty) {
                      setState(() {
                        checkListName.add(
                          SubTasks(
                            title: checklistcontroller.text,
                            isComplete: false,
                          ),
                        );
                      });
                    }
                    Navigator.pop(context);
                  },
                  child: Text("done"),
                ),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Create Your Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTile("Title", nameController),
              SizedBox(height: 20),
              CustomTile("Description", descriptionController),
              const SizedBox(height: 20),
              ElevatedButton(
                //-------------------Calender
                onPressed: () {
                  BottomPicker.date(
                    headerBuilder: (context) {
                      return Text(
                        'Set The Task Due Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      );
                    },
                    dateOrder: DatePickerDateOrder.dmy,

                    initialDateTime: DateTime.now(),
                    height: 500,
                    maxDateTime: DateTime.now().add(const Duration(days: 365)),
                    minDateTime: DateTime.now(),
                    pickerThemeData: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    onChange: (index) {
                      setState(() {
                        selectedDate = index;
                      });
                    },
                    onSubmit: (index) {
                      setState(() {
                        selectedDate = index;
                      });
                    },
                    onDismiss: (p0) {},
                  ).show(context);
                },
                style: ButtonStyle(
                  fixedSize: WidgetStatePropertyAll(Size(double.infinity, 50)),
                  backgroundColor: WidgetStatePropertyAll(Colors.white),

                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      side: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.calendar_month_rounded,
                      size: 35,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 30),
                    Text(
                      DateFormat.yMMMd().format(selectedDate),
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: WidgetStatePropertyAll(Size(double.infinity, 50)),
                  backgroundColor: WidgetStatePropertyAll(Colors.white),

                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      side: BorderSide(color: Colors.purpleAccent),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),

                onPressed: selectTime,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Icon(Icons.timer, size: 25),
                    const SizedBox(width: 30),
                    Text(
                      dateFormat(_selectedTime),
                      style: TextStyle(color: Colors.black, fontSize: 22),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: WidgetStatePropertyAll(Size(double.infinity, 50)),
                  backgroundColor: WidgetStatePropertyAll(Colors.white),

                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      side: BorderSide(color: Colors.greenAccent),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),

                onPressed: () {
                  DropDownState<String>(
                    dropDown: DropDown<String>(
                      isSearchVisible: false,
                      data: <SelectedListItem<String>>[
                        SelectedListItem<String>(data: Status.NotStarted.name),
                        SelectedListItem<String>(data: Status.InProgress.name),
                        SelectedListItem<String>(data: Status.Completed.name),
                        SelectedListItem<String>(data: Status.OnHold.name),
                        SelectedListItem<String>(data: Status.Dropped.name),
                      ],
                      onSelected: (selectedItems) {
                        setState(() {
                          if (selectedItems == Status.NotStarted) {
                            currentStatus = Status.NotStarted;
                          } else if (selectedItems == Status.InProgress) {
                            currentStatus = Status.InProgress;
                          } else if (selectedItems == Status.Completed) {
                            currentStatus = Status.Completed;
                          } else if (selectedItems == Status.OnHold) {
                            currentStatus = Status.OnHold;
                          } else if (selectedItems == Status.Dropped) {
                            currentStatus = Status.Dropped;
                          }
                        });
                      },
                    ),
                  ).showModal(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.auto_graph, size: 25),
                    const SizedBox(width: 30),
                    Text(
                      currentStatus.name,
                      style: TextStyle(color: Colors.black, fontSize: 22),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Icon(Icons.check_box_outlined, size: 30),
                        const SizedBox(width: 30),
                        Text(
                          "CheckList",
                          style: TextStyle(fontSize: 25, color: Colors.black),
                        ),
                        const SizedBox(width: 25),

                        TextButton(
                          onPressed: () {
                            _showDialogBox(context, checklistName);
                          },
                          child: Text(
                            "+ Add",
                            style: TextStyle(color: Colors.black, fontSize: 23),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 350,
                      child: const Divider(color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    if (checkListName.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "No SubTask has been Created",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ...checkListName.map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 5, bottom: 5),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              size: 8,
                              color: Colors.black54,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                item.title,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Colors.lightBlue.shade100,
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),

                        side: BorderSide(color: Colors.blue),
                      ),
                    ),
                    fixedSize: WidgetStatePropertyAll(Size(300, 50)),
                  ),

                  onPressed: () {
                    Todo newTodo = Todo(
                      dueDate: selectedDate,
                      taskStatus: currentStatus,
                      subTask: checkListName,
                      id: 0,
                      name: nameController.text,
                      description: descriptionController.text,
                      isCompleted: false,
                      creationDate: DateTime.now(),
                      dueTime: combineDateTimeAndTimeOfDay(
                        DateTime.now(),
                        _selectedTime,
                      ),
                    );
                    BlocProvider.of<TodoBloc>(
                      context,
                    ).add(CreateTodoEvent(newTodo));

                    Navigator.pop(context);
                  },
                  child: Text(
                    "Done...",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTile extends StatelessWidget {
  final String title;
  final TextEditingController controller;

  const CustomTile(this.title, this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),

        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: controller,
            maxLines: title == "Description" ? 3 : 1,
            decoration: InputDecoration(
              hintText: 'Enter your ${title.toLowerCase()}',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
