import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstacktodo/Modules/Home/data/model/Todo.dart';
import 'package:fullstacktodo/Modules/Home/data/model/status.dart';
import 'package:fullstacktodo/Modules/Home/data/repo/todoRepo.dart';
import 'package:fullstacktodo/Modules/Home/model_View/bloc/todo_bloc.dart';
import 'package:fullstacktodo/Modules/Home/view/Pages/Hompage.dart';
import 'package:fullstacktodo/Modules/Home/view/widgets/status_Template.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final Todorepo todorepo = Todorepo();
    return BlocProvider(
      create: (context) => TodoBloc(todorepo)..add(LoadTodoEvent()),
      child: Hompage(),
    );
  }
}
