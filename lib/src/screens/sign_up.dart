import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  String text = '';
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
        child: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(hintText: 'Email'),
              onSubmitted: emailSubmit,
            ),
            SizedBox(height: 40),
            TextField(
              decoration: InputDecoration(hintText: 'Password'),
            ),
            SizedBox(height: 40),
            RaisedButton(
              child: Text("Sign Up"),
              onPressed: () {},  
            ),
          ],
          ),
        )
      ),
    );
  }
}
