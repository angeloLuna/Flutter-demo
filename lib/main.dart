import 'package:flutter/material.dart';
import 'package:flutter_app/src/screens/champion.dart';
import 'package:flutter_app/src/screens/login.dart';
import 'package:flutter_app/src/screens/home.dart';
void main() {
  runApp(MaterialApp(
    home: Login(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.grey
    ),
    initialRoute: Login.routeName,
    routes: <String, WidgetBuilder> {
      Login.routeName: (BuildContext context) => Login(),
      Home.routeName: (BuildContext context) => Home(),
      Champion.routeName: (BuildContext context) => Champion()
    },
  ));
}

