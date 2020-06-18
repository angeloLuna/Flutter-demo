import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final MaterialAccentColor color;
  final String name;
  final VoidCallback onPressed;
  const AppButton({this.color, this.name, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(30),
          child: FlatButton(
            child: Text(name),
            onPressed: onPressed,
          ),
        ));
  }
}
