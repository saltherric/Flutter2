import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/artist/artist.dart';
import '../../dtos/artist_dto.dart';
import 'artist_repository.dart';

class ArtistRepositoryFirebase implements ArtistRepository {
  List<Artist>? _cachedArtists;

  final Uri artistsUri = Uri.https(
    'test-a2a77-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/artists.json',
  );

  @override
  Future<List<Artist>> fetchArtists({bool forceFetch = false}) async {
    // 1. Return cache if available
    if (!forceFetch && _cachedArtists != null) {
      return _cachedArtists!;
    }

    // 2. Otherwise fetch from API
    List<Artist> artists = await _fetchArtistsFromApi();

    // 3. Store in memory
    _cachedArtists = artists;

    return artists;
  }

  Future<List<Artist>> _fetchArtistsFromApi() async {
    final http.Response response = await http.get(artistsUri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load artists');
    }

    if (response.body == 'null') {
      return [];
    }

    Map<String, dynamic> songJson = json.decode(response.body);

    List<Artist> result = [];
    for (final entry in songJson.entries) {
      result.add(ArtistDto.fromJson(entry.key, entry.value));
    }

    return result;
  }

  @override
  Future<Artist?> fetchArtistById(String id) async {
    return null;
  }
}
