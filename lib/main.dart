import 'package:edcheck/notification_service.dart';
import 'package:flutter/material.dart';
// add  shared_preferences: ^2.0.9 dependency in pubspec.yml

import 'package:edcheck/gui/myapp.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  Future<bool> getIntFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final rememberMe = prefs.getBool('loggedIn');
    if (rememberMe == null || rememberMe == false) {
      return false;
    }
    return true;
  }

  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();

  runApp(MyApp());
}
