import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/mixins/validation_mixins.dart';
import 'package:flutter_app/src/screens/sign_up.dart';
import 'package:flutter_app/src/services/auth.dart';
import 'package:flutter_app/src/widgets/appTextField.dart';
import 'package:flutter_app/src/widgets/button.dart';
import 'package:flutter_app/src/widgets/error_message.dart';
import 'package:flutter_app/src/widgets/flatButton.dart';

class Login extends StatefulWidget {
  static const routeName = '';
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> with ValidationMixins{
  FirebaseUser loggedInUser;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  FocusNode _focusNode;
  bool _autovalidate = false;
  String _errorMessage = ''; 
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    getCurrentUser();
  }

  void getCurrentUser() async{
    print("init");
    var user = await Auth().getCurrentUser();
    if (user != null) {
      loggedInUser = user;
      print(loggedInUser.email);
      Navigator.pushNamed(context, '/home');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _emailField(),
              SizedBox(height: 40),
              _passwordField(),
              SizedBox(height: 40),
              _showErrorMessage(),
              _submitField(),
              _registerButton(),
            ],
            ),
          )
        ),
      ) 
    );
  }

  Widget _emailField() {
    return AppTextField(
      accent: Colors.amberAccent,
      controller: _emailController,
      autovalidate: _autovalidate,
      focusNode: _focusNode,
      hintText: "Email",
      validator: validateEmail,
      onSaved: (value) {},
    );
  }

  Widget _passwordField() {
    return AppTextField(
      hintText: "Password",
      autovalidate: _autovalidate,
      controller: _passwordController,
      obscureText: true,
      validator: validateLength,
      onSaved: (value) {},
    );
  }

  Widget _submitField() {
    return AppButton(
      color: Colors.greenAccent,
      name: "Login",
      onPressed: () async {
        if(_formKey.currentState.validate()) {
          var auth = await Auth().signIn(email: _emailController.text, password: _passwordController.text);
          if(auth.success) {
            print(auth);
            Navigator.pushNamed(context, '/home');
            _emailController.text = '';
            _passwordController.text = '';
            FocusScope.of(context).requestFocus(_focusNode);
          } else {
            setState(() => _errorMessage = auth.errorMessage);
          }
        } else {
          setState(() => _autovalidate = true);
        }
      },
    );
  }

  Widget _registerButton() {
    return AppButtonFlat(
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
    );
  }

  Widget _showErrorMessage() {
    if(_errorMessage.length > 0 && _errorMessage != null) {
      return ErrorMessage(errorMessage: _errorMessage);
    }
    return Container(height: 0,);
  }
}
