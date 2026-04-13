import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/models/todo_model.dart';
import 'package:todolist/services/database.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoDatabase db = TodoDatabase();

  TodoBloc() : super(TodoInitial()) {
    on<LoadTodos>(_loadTodos);
    on<AddTodo>(_addTodo);
    on<UpdateTodo>(_updateTodo);
    on<DeleteTodo>(_deleteTodo);
  }

  Future<void> _loadTodos(LoadTodos event, Emitter<TodoState> emit) async {
    emit(TodoLoading());

    final data = await db.getTodoItems();

    final todos =
        data.map((e) {
          return TodoModel(
            id: e['id'],
            title: e['title'],
            description: e['description'],
            date: e['date'],
          );
        }).toList();

    emit(TodoLoaded(todos));
  }

  Future<void> _addTodo(AddTodo event, Emitter<TodoState> emit) async {
    await db.insertTodoITem(event.data);
    add(LoadTodos());
  }

  Future<void> _updateTodo(UpdateTodo event, Emitter<TodoState> emit) async {
    await db.updateTodoItem(event.data);
    add(LoadTodos());
  }

  Future<void> _deleteTodo(DeleteTodo event, Emitter<TodoState> emit) async {
    await db.deleteTodoItem(event.id);
    add(LoadTodos());
  }
}
