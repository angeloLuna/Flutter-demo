import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/screens/sign_up.dart';
import 'package:flutter_app/src/widgets/appTextField.dart';
import 'package:flutter_app/src/widgets/button.dart';
import 'package:flutter_app/src/widgets/flatButton.dart';

class Login extends StatefulWidget {
  static const routeName = '';
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final auth = FirebaseAuth.instance;

  String _email;
  String _password;

  void emailSubmit(String value) {
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AppTextField(
              accent: Colors.amberAccent,
              hintText: "Email",
              onChanged: (value) {
                _email = value;
                print(_email);
              },
            ),
            SizedBox(height: 40),
            AppTextField(
              hintText: "Password",
              obscureText: true,
              onChanged: (value) {
                _password = value;
                print(_password);
              },
            ),
            SizedBox(height: 40),
            AppButton(
              color: Colors.greenAccent,
              name: "Login",
              onPressed: () {
                try {
                  var newUser = auth.createUserWithEmailAndPassword(email: _email, password: _password);
                  if(newUser != null) {
                    print(newUser);
                  }
                } catch (e) {
                  print(e);
                }
              },
            ),
            AppButtonFlat(
              name: 'Sign up',
              color: Colors.amberAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUp()
                  )
                );
              },
            ),
          ],
          ),
        )
      ),
    );
  }
}
