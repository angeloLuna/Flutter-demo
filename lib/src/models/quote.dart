import 'package:flutter_app/src/services/constants.dart';

class Album {
  final String name;
  final String lore;

  Album({this.name, this.lore,});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      name: json['data'][championName]['name'],
      lore: json['data'][championName]['lore'],
    );
  }
}