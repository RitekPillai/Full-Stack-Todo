import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:fullstacktodo/Modules/Home/data/model/Todo.dart';
import 'package:fullstacktodo/Modules/Home/data/repo/todoRepo.dart';
import 'package:fullstacktodo/Modules/Home/view/Pages/todoCreate.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final Todorepo _todorepo;

  TodoBloc(this._todorepo) : super(TodoInitial()) {
    on<LoadTodoEvent>((event, emit) async {
      try {
        //  emit(TodoLoading());
        final users = await _todorepo.fetchTodo();
        debugPrint(users.toString());
        emit(TodoLoaded(users));
      } catch (e) {
        emit(TodoFailed(e.toString()));
      }
    });

    on<CreateTodoEvent>(_onCreateTodo);
    on<DeleteTodoEvent>(_onTodoDelete);
    on<UpdateTodoEvent>(_onUpdate);
  }

  Future<void> _onTodoDelete(
    DeleteTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());
    try {
      await _todorepo.deleteTodo(event.todoId);

      add(LoadTodoEvent());
    } catch (e) {
      emit(TodoFailed(e.toString()));
    }
  }

  Future<void> _onUpdate(UpdateTodoEvent event, Emitter<TodoState> emit) async {
    var currentState = state;
    emit(TodoLoading());
    try {
      final updatedTodo = await _todorepo.updateTodo(event.newTodo);
      if (currentState is TodoLoaded) {
        final List<Todo> updatedList = currentState.todo.map((todo) {
          if (todo.id == updatedTodo.id) {
            return updatedTodo;
          }
          return todo;
        }).toList();

        emit(TodoLoaded(updatedList));
      }
    } catch (e) {
      emit(TodoFailed(e.toString()));
    }
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
      emit(TodoFailed("Failed to create todo: ${e.toString()}"));
    }
  }

  @override
  void onChange(Change<TodoState> change) {
    debugPrint(change.currentState.toString());
    debugPrint(change.nextState.toString());
    super.onChange(change);
  }
}
