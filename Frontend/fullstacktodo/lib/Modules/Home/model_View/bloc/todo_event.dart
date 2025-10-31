part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

class LoadTodoEvent extends TodoEvent {}

class CreateTodoEvent extends TodoEvent {
  final Todo newTodo;
  CreateTodoEvent(this.newTodo);
}

class DeleteTodoEvent extends TodoEvent {
  final int todoId;
  DeleteTodoEvent(this.todoId);
}

class UpdateTodoEvent extends TodoEvent {
  final Todo newTodo;
  UpdateTodoEvent(this.newTodo);
}
