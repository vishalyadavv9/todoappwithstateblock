import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TodoDatabase {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await createDB();
    return _db!;
  }

  Future<Database> createDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), "TodoDB.db"),
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE Todo(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            date TEXT,
            description TEXT
          )
        ''');
      },
    );
  }

  Future<List<Map>> getTodoItems() async {
    final db = await database;
    return await db.query("Todo");
  }

  Future<void> insertTodoITem(Map<String, dynamic> obj) async {
    final db = await database;
    await db.insert("Todo", obj, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateTodoItem(Map<String, dynamic> obj) async {
    final db = await database;
    await db.update("Todo", obj, where: "id=?", whereArgs: [obj['id']]);
  }

  Future<void> deleteTodoItem(int id) async {
    final db = await database;
    await db.delete("Todo", where: "id=?", whereArgs: [id]);
  }
}
