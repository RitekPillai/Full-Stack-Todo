import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:fullstacktodo/Modules/Home/data/model/Todo.dart';
import 'package:fullstacktodo/Modules/Home/data/repo/todoRepo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final Todorepo _todorepo;

  TodoBloc(this._todorepo) : super(TodoInitial()) {
    // 1. Register the Load event
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

    on<CreateTodoEvent>(_onCreateTodo);
  }

  Future<void> _onCreateTodo(
    CreateTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    final currentState = state;

    emit(TodoLoading());

    try {
      final newTodo = await _todorepo.createTodo(event.newTodo);

      if (currentState is TodoLoaded) {
        final List<Todo> updatedList = [...currentState.todo, newTodo];

        emit(TodoLoaded(updatedList));
      } else {
        emit(TodoCreated(newTodo));
      }
    } catch (e) {
      debugPrint(e.toString());
      // On failure, emit the error state.
      emit(TodoFailed("Failed to create todo: ${e.toString()}"));
    }
  }

  @override
  void onChange(Change<TodoState> change) {
    // TODO: implement onChange
    debugPrint(change.currentState.toString());
    debugPrint(change.nextState.toString());
    super.onChange(change);
  }
}
