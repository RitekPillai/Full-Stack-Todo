part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

class LoadTodoEvent extends TodoEvent {}

class CreateTodoEvent extends TodoEvent {
  final Todo newTodo;
  CreateTodoEvent(this.newTodo);
}
