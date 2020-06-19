import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget{
  final String errorMessage;
  ErrorMessage({this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        errorMessage,
        style: TextStyle(
          fontSize: 13,
          color: Colors.red,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}