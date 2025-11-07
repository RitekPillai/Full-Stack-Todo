part of 'todo_bloc.dart';

@immutable
abstract class TodoState extends Equatable {
  const TodoState();
  @override
  List<Object> get props => [];
}

final class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> todo;
  final String username;
  const TodoLoaded(this.todo, this.username);
  @override
  List<Object> get props => [todo];
}

class TodoCreated extends TodoState {
  final Todo todo;
  const TodoCreated(this.todo);
  @override
  List<Object> get props => [todo];
}

class TodoUpdate extends TodoState {
  final Todo todo;
  const TodoUpdate(this.todo);
  @override
  List<Object> get props => [todo];
}

class TodoDeleted extends TodoState {}

class TodoFailed extends TodoState {
  final String error;
  const TodoFailed(this.error);
  @override
  List<Object> get props => [error];
}
