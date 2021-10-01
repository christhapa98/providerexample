  import 'package:todos/models/todos_model.dart';

Future fetchTodos(db) async {
    var todos = await db.myTodos();
    Iterable data = todos;
    var todoslist = data.map((e) => TodosModel.fromJson(e)).toList();
    return todoslist;
  }
