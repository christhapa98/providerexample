import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todos/services/firebase_service.dart';

showNotification(title, description) {
  flutterLocalNotificationsPlugin.show(
      0,
      title,
      description,
      NotificationDetails(
          android: AndroidNotificationDetails(
              channel.id, channel.name, channel.description,
              importance: Importance.low,
              color: Colors.blue,
              // playSound: true,
              icon: '@mipmap/ic_launcher')));
}
