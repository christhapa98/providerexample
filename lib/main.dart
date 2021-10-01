import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/provider/app_provider.dart';
import 'package:todos/screens/home_screen.dart';
import 'package:todos/services/firebase_service.dart';

Future<void> main() async {
  //Initializing provider from main root to subroot widgets
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  getToken() async {
    var token = await FirebaseMessaging.instance.getToken();
    print(token.toString());
  }

  @override
  void initState() {
    firebaseInitialization();
    firebaseOnMessageListener();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppProvider>(context);
    var mode = user.themeMode;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: mode ? Brightness.light : Brightness.dark),
      home: HomeScreen(),
    );
  }
}
