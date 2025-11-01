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
  int index;
  Todo? todo;
  Todocreate({required this.index, super.key, this.todo});

  @override
  State<Todocreate> createState() => _TodocreateState();
}

var currentStatus = Status.InProgress;

class _TodocreateState extends State<Todocreate> {
  @override
  void initState() {
    super.initState();

    if (widget.todo != null && widget.index != 0) {
      nameController.text = widget.todo!.name;
      descriptionController.text = widget.todo!.description;
      selectedDate = widget.todo!.dueDate!;
      currentStatus = widget.todo!.taskStatus;
      checkListName.addAll(widget.todo!.subTask);

      _selectedTime = TimeOfDay.fromDateTime(widget.todo!.dueTime!);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    descriptionController.dispose();
    checklistName.dispose();
    super.dispose();
  }

  TimeOfDay _selectedTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  TextEditingController checklistName = TextEditingController();
  //VARIABLESSSSSSS

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
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

    void showDialogBox(context, TextEditingController checklistcontroller) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("CheckList"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: checklistcontroller,
                  decoration: InputDecoration(hintText: "Enter Title"),
                ),
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
      appBar: AppBar(
        title: widget.index == 0
            ? const Text("Create Your Task")
            : const Text("Update Your Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTile(
                widget.index,
                "Title",
                nameController,
                todo: widget.todo,
              ),
              SizedBox(height: 20),
              CustomTile(
                widget.index,
                "Description",
                descriptionController,
                todo: widget.todo,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                //-------------------------------------------------------------Calender
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
                  DropDownState<Status>(
                    dropDown: DropDown<Status>(
                      isSearchVisible: false,
                      data: <SelectedListItem<Status>>[
                        SelectedListItem<Status>(data: Status.NotStarted),
                        SelectedListItem<Status>(data: Status.InProgress),
                        SelectedListItem<Status>(data: Status.Completed),
                        SelectedListItem<Status>(data: Status.OnHold),
                        SelectedListItem<Status>(data: Status.Dropped),
                      ],

                      onSelected: (selectedItems) {
                        setState(() {
                          final Status selectedName = selectedItems.first.data;
                          currentStatus = Status.values.firstWhere(
                            (status) => status.name == selectedName.name,
                            orElse: () => Status.NotStarted,
                          );
                        });
                        print(currentStatus);
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
                  color: Colors.amber.shade100,
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
                            showDialogBox(context, checklistName);
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
                    Todo finalTodo = Todo(
                      dueDate: selectedDate,
                      taskStatus: currentStatus,
                      subTask: checkListName,

                      id: widget.index == 0 ? 0 : widget.todo!.id!,

                      name: nameController.text,
                      description: descriptionController.text,

                      isCompleted: widget.todo?.isCompleted ?? false,
                      creationDate: widget.todo?.creationDate ?? DateTime.now(),

                      dueTime: combineDateTimeAndTimeOfDay(
                        selectedDate,
                        _selectedTime,
                      ),
                    );

                    widget.index == 0
                        ? BlocProvider.of<TodoBloc>(
                            context,
                          ).add(CreateTodoEvent(finalTodo))
                        : BlocProvider.of<TodoBloc>(
                            context,
                          ).add(UpdateTodoEvent(finalTodo));

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
  int index;
  Todo? todo;
  final TextEditingController controller;

  CustomTile(this.index, this.title, this.controller, {this.todo, super.key});

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
              hintText: index == 0
                  ? 'Enter your ${title.toLowerCase()}'
                  : title == "Description"
                  ? todo!.description
                  : todo!.name,
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
