import 'dart:convert';

String todosmodelToJson(TodosModel data) => json.encode(data.toMap());

class TodosModel {
  TodosModel({this.title, this.description, this.id});
  var title;
  var description;
  var id;

  Map<String, dynamic> toMap() {
    return {"title": title, "description": description, "id": id};
  }

  TodosModel.fromJson(Map<String, dynamic> todo) {
    this.title = todo['title'];
    this.description = todo['description'];
    this.id = todo['id'];
  }
}
