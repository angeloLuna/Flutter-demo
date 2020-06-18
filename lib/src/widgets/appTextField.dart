import 'package:flutter/material.dart';
import 'package:flutter_app/src/mixins/validation_mixins.dart';

class AppTextField extends StatelessWidget with ValidationMixins {
  final MaterialAccentColor accent;
  final String hintText;
  final ValueChanged onChanged;
  final bool obscureText;

  const AppTextField({this.accent, this.hintText, this.onChanged, this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: validateRequired,
      onChanged: onChanged,
      obscureText: obscureText == null ? false : obscureText,
    );
  }
}