import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/constants/responsive.dart';
import 'package:todos/constants/scaling.dart';
import 'package:todos/db/db.dart';
import 'package:todos/models/todos_model.dart';
import 'package:todos/provider/app_provider.dart';
import 'package:todos/services/firebase_service.dart';
import 'package:todos/services/notification_service.dart';
import 'package:todos/services/todo_service.dart';
import 'package:todos/widgets/button_widget.dart';
import 'package:todos/widgets/input_widget.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var db = DBProvider.db;
  var myTodos = [];
  var todo = {'title': '', 'description': ''};

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  getTodosData() async {
    var data = await fetchTodos(db);
    setState(() {
      myTodos = data;
    });
  }

  void initState() {
    super.initState();
    getTodosData();
    showNotification('title', 'description');
    firebaseOnMessageListener();
    firebaseonMessageOpenedApp(context);
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppProvider>(context);

    uploadTodos() async {
      TodosModel todos = TodosModel(
        title: titleController.text,
        description: descriptionController.text,
      );
      setState(() {
        myTodos = [...myTodos, todos];
      });

      await db.addTodos(todos);
      Future.delayed(const Duration(milliseconds: 2),
          showNotification(titleController.text, descriptionController.text));
      Navigator.pop(context);
      titleController.clear();
      descriptionController.clear();
    }

    deleteTodos(id) async {
      await db.deleteTodo(id);
      await getTodosData();
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
        centerTitle: true,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              backgroundColor: appState.mode ? Colors.black12 : Colors.amber,
              heroTag: "btn2",
              onPressed: () => appState.toogleMode(),
              child: appState.mode
                  ? FaIcon(FontAwesomeIcons.solidMoon,)
                  : Icon(
                      Icons.wb_sunny,
                      color: Colors.white,
                    ),
            ),
            SizedBox(width: 15),
            FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: EdgeInsets.all(15),
                      child: SingleChildScrollView(
                        child:
                            Center(child: todoForm(uploadTodos: uploadTodos)),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(child: todoBody(context, deleteTodos)),
    );
  }

  Container todoBody(
      BuildContext context, Future<dynamic> deleteTodos(dynamic id)) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: scaling(context, 20), vertical: 15),
        child: ListView.builder(
          itemCount: myTodos.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: scaling(context, 30),
                          vertical: scaling(context, 20)),
                      child: ButtonWidget(
                        title: 'Delete',
                        color: Colors.red,
                        radius: 10,
                        onPress: () {
                          deleteTodos(myTodos[index].id);
                        },
                      ),
                    );
                  },
                );
              },
              child: ListTile(
                title: Text('${myTodos[index].title}'),
                subtitle: Text('${myTodos[index].description}'),
                leading: Icon(Icons.add_box_rounded),
              ),
            );
          },
        ));
  }

  Responsive todoForm({uploadTodos}) {
    return Responsive(
        mobile: formMobile(uploadTodos),
        tablet: formTablet(uploadTodos),
        desktop: formTablet(uploadTodos));
  }

  Column formMobile(uploadTodos) {
    return Column(
      children: [
        InputWidget(
          controller: titleController,
          label: 'Enter Todo Title',
        ),
        SizedBox(
          height: scaling(context, 20),
        ),
        InputWidget(
          controller: descriptionController,
          label: 'Enter Todo Description',
        ),
        SizedBox(
          height: scaling(context, 20),
        ),
        ButtonWidget(
          title: 'Add Todos',
          onPress: () {
            uploadTodos();
          },
          color: Colors.red,
          radius: 15,
        ),
      ],
    );
  }

  Container formTablet(uploadTodos) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: InputWidget(
                  controller: titleController,
                  label: 'Enter Todo Title',
                ),
              ),
              SizedBox(
                width: scaling(context, 20),
              ),
              Expanded(
                child: InputWidget(
                  controller: descriptionController,
                  label: 'Enter Todo Description',
                ),
              ),
              SizedBox(
                width: scaling(context, 20),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 25),
            child: ButtonWidget(
              title: 'Add Todos',
              onPress: () {
                uploadTodos();
              },
              color: Colors.red,
              radius: 15,
            ),
          )
        ],
      ),
    );
  }
}
