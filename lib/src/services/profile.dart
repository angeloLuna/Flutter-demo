import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  final _firestore = Firestore.instance;

  Future<QuerySnapshot> getUserProfile(String uid) async{
    return await _firestore.collection('users').getDocuments();
  }

}