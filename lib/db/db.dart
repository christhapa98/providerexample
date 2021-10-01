import 'package:sqflite/sqflite.dart';
import 'package:todos/models/todos_model.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await startDB();
    return _database;
  }

  startDB() async {
    var databasePath = await getDatabasesPath();
    return await openDatabase((databasePath + '/todo-db.db'),
        version: 1, onOpen: (db) {}, onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, description TEXT)',
      );
    });
  }

  void deleteT() async {
    await _database.execute("DROP TABLE IF EXISTS todos");
  }

  //adding Todos
  Future<void> addTodos(TodosModel todos) async {
    final db = await database;
    var result = await db.insert(
      'todos',
      todos.toMap(),
    );
    print(result);
  }

  //getting Todos
  Future myTodos() async {
    final db = await database;
    final todos = await db.query('todos');
    return todos;
  }

  Future<void> deleteTodo(int id) async {
    final db = await database;
    await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
