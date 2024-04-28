import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'SignUp.dart';
import 'dbHelper.dart'; // Import your SignUp widget file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SignUp(), // Set SignUp widget as the home
    );
  }
}
