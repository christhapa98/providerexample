import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  var mode = true;

  get themeMode => mode;

  toogleMode() {
    mode = !mode;
    notifyListeners();
  }
}
