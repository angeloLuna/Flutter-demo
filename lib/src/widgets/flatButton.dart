import 'package:flutter/material.dart';

class AppButtonFlat extends StatelessWidget {
  final MaterialAccentColor color;
  final String name;
  final VoidCallback onPressed;
  const AppButtonFlat({this.color, this.name, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        child: FlatButton(
          child: Text(
            name,
            style: TextStyle(
              fontSize: 12,
              color: color
            )
          ),
          onPressed: onPressed
        ));
  }
}
