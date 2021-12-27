import 'package:edcheck/notification_service.dart';
import 'package:flutter/material.dart';
// add  shared_preferences: ^2.0.9 dependency in pubspec.yml

import 'package:edcheck/gui/myapp.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  //final prefs = await SharedPreferences.getInstance();

  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();

  runApp(MyApp());
}
