import 'package:flutter/material.dart';
import 'package:flutter_app/src/screens/champion.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  
  @override
  Widget build(BuildContext context) {
    return 
    DefaultTabController(
  length: 2,
  child: Scaffold(
    appBar: AppBar(
      title: Text('Quotes'),
      bottom: TabBar(
        tabs: [
          Tab(text: 'Quote of the day'),
          Tab(text: 'Best quotes LoL'),
        ],
      ),
    ),
    body: TabBarView(children: <Widget>[
      Champion(),
      Text('another')
    ],),
  ),
);
  }
}
