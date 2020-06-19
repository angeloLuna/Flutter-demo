import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/services/auth.dart';
import 'package:flutter_app/src/services/httpHandler.dart';
import 'package:flutter_app/src/models/quote.dart';

import 'package:flutter_app/src/services/profile.dart';

class Home extends StatefulWidget {
  static const String routeName = '/home';
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final Future<Album> album = HttpHandler().fetchAlbum();
  FirebaseUser isUser;
  var profileData;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    var user = await Auth().getCurrentUser();
    isUser = user;
    final profiles = await Profile().getUserProfile(isUser.uid);
    if (profiles != null) {
      print(profiles);
      for (var prof in  profiles.documents) {
        print(prof.documentID);
        print('entro ' + isUser.uid);
        if (prof.documentID == isUser.uid) {
          print(prof.data);
          setState(() => profileData = prof.data);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Quotes'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.power_settings_new),
                onPressed: () {
                  Auth().signOut();
                  Navigator.pop(context);
                })
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'Quote of the day'),
              Tab(text: 'Profile'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: _contentChampion(),
            ),
            _profileData(),
          ],
        ),
      ),
    );
  }

  Widget _contentChampion() {
    return FutureBuilder<Album>(
      future: album,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            margin: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  snapshot.data.name,
                  style: TextStyle(fontSize: 24),
                ),
                Padding(padding: EdgeInsets.all(16.0)),
                Text(
                  snapshot.data.lore,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        } else {
          return Text("${snapshot.error}");
        }
      },
    );
  }

  Widget _profileData() {
    if (profileData != null) {
      return Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Name: ' + profileData['name'], style: TextStyle(fontSize: 22)),
            Padding(padding: EdgeInsets.all(8.0)),
            Text('Last name: ' + profileData['lastName'], style: TextStyle(fontSize: 22)),
            Padding(padding: EdgeInsets.all(8.0)),
            Text('Phone: ' + profileData['phone'], style: TextStyle(fontSize: 22)),
            Padding(padding: EdgeInsets.all(8.0)),
            Text('Email: ' + profileData['email'], style: TextStyle(fontSize: 22)),
            Padding(padding: EdgeInsets.all(8.0)),
            Text('Email: ' + profileData['address'], style: TextStyle(fontSize: 22)),
        ],),
      );

    }
    return Text('');
  }

}
