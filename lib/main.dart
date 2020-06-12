import 'package:flutter/material.dart';
import 'package:flutter_app/src/champion.dart';
import 'package:flutter_app/src/screens/login.dart';
import 'package:flutter_app/src/home.dart';
void main() {
  runApp(MaterialApp(
    home: Login(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.grey
    ),
  ));
}

