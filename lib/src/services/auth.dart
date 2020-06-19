import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app/src/models/authentication_request.dart';
import 'dart:io';

class Auth{
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  

  Future<AuthenticationRequest> createUser({String email = '', String password = '', String name = '', String phone = '', String address = '', String lastName = '', File img}) async {
    AuthenticationRequest authRequest = AuthenticationRequest();
    try {
      final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: email,
    ))
        .user;
      if (user != null) {
        authRequest.success = true;
        var uid = user.uid;
        print(uid);
        _firestore.collection('users').document(uid).setData({
          'name': name,
          'lastName': lastName,
          'phone': phone,
          'address': address,
          'email': user.email,
        });
        _uploadFile(uid: uid, image: img);
      }
    } catch(e) {
      _mapErrorMessage(authRequest, e.code);
    }
    return authRequest;
  }

  Future<AuthenticationRequest> signIn({String email = '', String password = ''}) async {
    AuthenticationRequest authRequest = AuthenticationRequest();
    try {
      var user =  await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (user != null) {
        authRequest.success = true;
      }
    } catch(e) {
      _mapErrorMessage(authRequest, e.code);
    }
    return authRequest;
  }

  Future<FirebaseUser> getCurrentUser() async {
    try {
      return await _auth.currentUser();
    } catch(e) {
      print (e);
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print (e);
    }
    return null;
  }

  void _mapErrorMessage(AuthenticationRequest authRequest, String code) {
    switch(code){
      case 'ERROR_USER_NOT_FOUND':
        authRequest.errorMessage = 'User not found';
        break;
      case 'ERROR_WRONG_PASSWORD':
        authRequest.errorMessage = 'Wrong password';
        break;
      case 'ERROR_NETWORK_REQUEST_FAILED':
        authRequest.errorMessage = 'Network error';
        break;
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        authRequest.errorMessage = 'Email already in use';
        break;
      default: 
        authRequest.errorMessage = code;
    }
  }

  Future<void> _uploadFile({String uid = '', File image}) async {    
   StorageReference storageReference = FirebaseStorage.instance    
       .ref()    
       .child('fondeadora/$uid');    
   StorageUploadTask uploadTask = storageReference.putFile(image);    
   await uploadTask.onComplete;    
   print('File Uploaded');    
   storageReference.getDownloadURL().then((fileURL) {    
     print(fileURL);
   });    
 }  

}