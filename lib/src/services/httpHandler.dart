import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_app/src/models/quote.dart';
import 'package:flutter_app/src/services/constants.dart';

class HttpHandler {
  Future<Album> fetchAlbum() async {
    final response =
        await http.get('http://ddragon.leagueoflegends.com/cdn/8.23.1/data/en_US/champion/$championName.json');
    if (response.statusCode == 200) {
      return Album.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Album> fetchPlanet(String url) async {
    final response =
        await http.get(url);
    if (response.statusCode == 200) {
      return Album.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}
  