import 'package:flutter/material.dart';
import 'package:testing/screens/LoginScreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreenPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
