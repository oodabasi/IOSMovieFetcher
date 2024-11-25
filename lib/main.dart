import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TMDb Movie App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(), // Start with the Login Page
    );
  }
}
