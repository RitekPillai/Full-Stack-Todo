import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstacktodo/Modules/Home/model_View/bloc/todo_bloc.dart';
import 'package:fullstacktodo/Modules/Home/view/widgets/todo_Tile.dart';

class Homepagestate extends StatelessWidget {
  const Homepagestate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffb4c4fe),
      appBar: AppBar(title: Text("Todo")),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoInitial) {
            return const Center(child: Text('Press button to load users'));
          } else if (state is TodoLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TodoLoaded) {
            if (state.todo.isEmpty) {
              return Center(
                child: Text(
                  "No Todo Created (T-T) Tap + to Create",
                  style: TextStyle(),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: state.todo.length,
                itemBuilder: (context, index) {
                  return todoTile(
                    state.todo[index].name,
                    state.todo[index].description,
                    state.todo[index].isCompleted,
                  );
                },
              );
            }
          } else if (state is TodoFailed) {
            return Center(
              child: Text(state.error, style: TextStyle(fontSize: 30)),
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text("+"),
      ),
    );
  }
}
