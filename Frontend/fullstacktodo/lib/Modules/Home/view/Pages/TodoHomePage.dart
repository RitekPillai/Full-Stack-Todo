import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstacktodo/Modules/Home/data/repo/todoRepo.dart';
import 'package:fullstacktodo/Modules/Home/model_View/bloc/todo_bloc.dart';
import 'package:fullstacktodo/Modules/Home/view/Pages/HomePageState.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final Todorepo todorepo = Todorepo();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(todorepo)..add(LoadTodoEvent()),
      child: Homepagestate(),
    );
  }
}
