import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:fullstacktodo/Modules/Home/data/model/Todo.dart';
import 'package:fullstacktodo/Modules/Home/data/repo/todoRepo.dart';
import 'package:meta/meta.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final Todorepo _todorepo;

  TodoBloc(this._todorepo) : super(TodoInitial()) {
    on<LoadTodoEvent>((event, emit) async {
      emit(TodoLoading());
      try {
        final users = await _todorepo.fetchTodo();
        debugPrint(users.toString());
        emit(TodoLoaded(users));
      } catch (e) {
        emit(TodoFailed(e.toString()));
      }
    });
  }
  @override
  void onChange(Change<TodoState> change) {
    // TODO: implement onChange
    debugPrint(change.currentState.toString());
    debugPrint(change.nextState.toString());
    super.onChange(change);
  }
}
