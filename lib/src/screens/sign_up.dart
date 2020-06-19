import 'package:flutter/material.dart';
import 'package:flutter_app/src/services/auth.dart';
import 'package:flutter_app/src/widgets/error_message.dart';
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
  bool _autovalidate = false;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _nameController;
  TextEditingController _lastNameController;
  TextEditingController _phoneController;
  TextEditingController _addressController;
  String _errorMessage = '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
  }
  

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
            _showErrorMessage(),
            FlatButton(
              child: Text("Profile image"),
              color: Colors.indigoAccent,
              onPressed: getImage
            ),
            SizedBox(height: 10),
            _image == null
            ? Text('No image selected.')
            : Image.file(_image, height: 80, width: 80,),
            submitButton(),
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
      controller: _nameController,
      autovalidate: _autovalidate,
      validator: validateRequired,
    );
  }
  Widget lastNameField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Last Name'
      ),
      controller: _lastNameController,
      autovalidate: _autovalidate,
      validator: validateRequired,
    );
  }
  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      decoration: InputDecoration(
        hintText: 'Email'
      ),
      autovalidate: _autovalidate,
      validator: validateEmail,
    );
  }
  Widget phoneField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: 'Phone'
      ),
      controller: _phoneController,
      autovalidate: _autovalidate,
      validator: validateRequired,
    );
  }
  Widget addressField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Address'
      ),
      controller: _addressController,
      autovalidate: _autovalidate,
      validator: validateRequired,
    );
  }
  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      autovalidate: _autovalidate,
      controller: _passwordController,
      decoration: InputDecoration(
        hintText: 'Password'
      ),
      validator: validateLength,
    );
  }

  Widget submitButton() {
    return RaisedButton(
      child: Text('Submit'),
      onPressed: () async{
        if (formKey.currentState.validate()) {
          if (_image != null) {
            var auth = await Auth().createUser(
              email: _emailController.text,
              password: _passwordController.text,
              name: _nameController.text,
              lastName: _lastNameController.text,
              phone: _phoneController.text,
              address: _addressController.text,
              img: _image
            );
            if(auth.success) {
              print(auth);
              _emailController.text = '';
              _passwordController.text = '';
              _nameController.text = '';
              _lastNameController.text = '';
              _addressController.text = '';
              _phoneController.text = '';
              setState(() => _errorMessage = '');
              Navigator.pushNamed(context, '/home');
            } else {
              setState(() => _errorMessage = auth.errorMessage);
            }
          } else {
            setState(() => _errorMessage = "Select an image");
          }
        } else setState(() => _autovalidate = true);
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
