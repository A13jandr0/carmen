import 'package:flutter/material.dart';
import 'welcome_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bienvenido',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(username: 'Usuario'),
    );
  }
}
