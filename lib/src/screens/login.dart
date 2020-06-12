import 'package:flutter/material.dart';
import 'package:flutter_app/src/screens/sign_up.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
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
        title: Text('Login'),
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
              child: Text("Login"),
              onPressed: () {},  
            ),
            FlatButton(
              child: Text(
                'Sign Up',
                style: TextStyle(fontSize: 12, color: Colors.grey)
                ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUp()
                  )
                );
              },)
          ],
          ),
        )
      ),
    );
  }
}
