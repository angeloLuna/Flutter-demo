import 'package:flutter/material.dart';

class Champion extends StatefulWidget {
  @override
  ChampionState createState() => ChampionState();
}

class ChampionState extends State<Champion> {
  String championName = '';
  int index = 0;
  List<Map> collections = [
    {
      'id': 'Kled',
      'quotes': ['No se puede razonar conmigo', 'Diré algo muy ingenioso después de matarte', 'Primero los matamos, luego los obligamos a decirnos de dónde vinieron', ]
    },{},{}];
    void onPressButton() {
      index++;
      index = index < 3 ? index++ : 0;
      var arr = collections[0];
      setState(() {
        championName = arr['quotes'][index];
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stateful'),
      ),
      body: Container(
        child: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(championName, style: TextStyle(fontSize: 40.0),),
            RaisedButton(
              child: Text("Press"),
              onPressed: onPressButton,  
            )
          ],
          ),
        )
      ),
    );
  }
}
