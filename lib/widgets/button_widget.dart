import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {
  ButtonWidget({@required this.title, this.onPress, this.color, this.radius});
  Function onPress;
  String title;
  Color color;
  double radius;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      child: Text(title),
      color: color != null ? color : Colors.red,
      minWidth: double.infinity,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
    );
  }
}
