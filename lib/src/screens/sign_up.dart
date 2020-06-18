import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_app/src/mixins/validation_mixins.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with ValidationMixins {
  String text = '';
  File _image;
  final picker = ImagePicker();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void emailSubmit(String value) {
    setState(() {
      text = value;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: formKey,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            nameField(),
            lastNameField(),
            emailField(),
            phoneField(),
            addressField(),
            passwordField(),
            submitButton(),
            // FlatButton(
            //   child: Text("Profile image"),
            //   color: Colors.indigoAccent,
            //   onPressed: getImage
            // ),
            // SizedBox(height: 10),
            // _image == null
            // ? Text('No image selected.')
            // : Image.file(_image, height: 80, width: 80,),
            // SizedBox(height: 40),
            // RaisedButton(child: Text('Sign Up'), onPressed: () {},)
          ],
          ),
        )
      ),
    );
  }

  Widget nameField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Name'
      ),
      validator: validateRequired,
    );
  }
  Widget lastNameField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Last Name'
      ),
      validator: validateRequired,
    );
  }
  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email'
      ),
      validator: validateEmail,
    );
  }
  Widget phoneField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: 'Phone'
      ),
      validator: validateRequired,
    );
  }
  Widget addressField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Address'
      ),
      validator: validateRequired,
    );
  }
  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password'
      ),
      validator: validateLength,
    );
  }

  Widget submitButton() {
    return RaisedButton(
      child: Text('Submit'),
      onPressed: () {
        formKey.currentState.validate();
      },
    );
  }
}
