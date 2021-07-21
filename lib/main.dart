import 'package:flutter/material.dart';
import 'package:flutter_starter/screens/home.dart';
import 'package:flutter_starter/utils/utilities.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Starter',
      navigatorKey: Utils.navigatorkey,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomeScreen(),
    );
  }
}
