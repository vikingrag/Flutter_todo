import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/home.dart';
import 'package:flutter_todo/pages/main_screen.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Инициализация в основной функции
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.deepOrangeAccent,
    ),
    initialRoute: '/',
    routes: {
      // Маршрутизация
      '/': (context) => MainScreen(),
      '/todo': (context) => Home(),
    },
  ));
}