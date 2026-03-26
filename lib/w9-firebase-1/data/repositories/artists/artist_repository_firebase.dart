import 'dart:convert';

import 'package:flutter2/w9-firebase-1/data/dtos/artist_dto.dart';
import 'package:flutter2/w9-firebase-1/data/repositories/artists/artist_repository.dart';
import 'package:flutter2/w9-firebase-1/model/artists/artist.dart';
import 'package:http/http.dart' as http;

class ArtistRepositoryFirebase extends ArtistRepository {
  final Uri artistsUri = Uri.https(
    'visal-db-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/artists.json',
  );

  @override
  Future<List<Artist>> fetchArtists() async {
    final http.Response response = await http.get(artistsUri);

    if (response.statusCode == 200) {
      if (response.body == 'null') {
        return [];
      }

      Map<String, dynamic> artistJson = json.decode(response.body);

      List<Artist> artists = [];

      for (var entry in artistJson.entries) {
        String id = entry.key;
        Map<String, dynamic> data = entry.value;

        artists.add(ArtistDto.fromJson(id, data));
      }

      return artists;
    } else {
      throw Exception('Failed to load artists');
    }
  }

  @override
  Future<Artist?> fetchArtistById(String id) async {
    return null;
  }
}