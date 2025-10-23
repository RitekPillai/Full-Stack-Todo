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
  const TodoLoaded(this.todo);
  @override
  List<Object> get props => [todo];
}

class TodoFailed extends TodoState {
  final String error;
  const TodoFailed(this.error);
  @override
  List<Object> get props => [error];
}
