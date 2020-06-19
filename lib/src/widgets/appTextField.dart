import 'package:flutter/material.dart';
import 'package:flutter_app/src/mixins/validation_mixins.dart';

class AppTextField extends StatelessWidget with ValidationMixins {
  final MaterialAccentColor accent;
  final String hintText;
  final ValueChanged onSaved;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FormFieldValidator<String> validator;
  final bool autovalidate;

  const AppTextField({
    this.accent,
    this.hintText,
    this.onSaved,
    this.obscureText,
    this.controller,
    this.focusNode,
    this.validator,
    this.autovalidate
    });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: validator,
      focusNode: focusNode,
      controller: controller,
      onSaved: onSaved,
      autovalidate: autovalidate,
      obscureText: obscureText == null ? false : obscureText,
    );
  }
}