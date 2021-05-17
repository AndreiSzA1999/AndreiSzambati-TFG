import 'package:aszcars_tfg_andrei/screens/first_screen/first_screen_page.dart';
import 'package:aszcars_tfg_andrei/screens/home_page/home_page.dart';
import 'package:aszcars_tfg_andrei/screens/login/login_page.dart';
import 'package:aszcars_tfg_andrei/screens/register/register_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ASZCARS',
      initialRoute: 'home',
      routes: {
        'home': (context) => FirstScreenPage(),
        'login': (context) => LoginPage(),
        'register': (context) => RegisterPage(),
      },
    );
  }
}
