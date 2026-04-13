abstract class TodoEvent {}

class LoadTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final Map<String, dynamic> data;
  AddTodo(this.data);
}

class UpdateTodo extends TodoEvent {
  final Map<String, dynamic> data;
  UpdateTodo(this.data);
}

class DeleteTodo extends TodoEvent {
  final int id;
  DeleteTodo(this.id);
}
