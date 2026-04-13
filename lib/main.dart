import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/todo/todo_bloc.dart';
import 'package:todolist/bloc/todo/todo_event.dart';
import 'package:todolist/views/todo_ui_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    BlocProvider(create: (_) => TodoBloc()..add(LoadTodos()), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: TodoUiScreen());
  }
}
