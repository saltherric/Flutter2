import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  List<Song>? _cachedSongs;

  final Uri songsUri = Uri.https(
    'test-a2a77-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/songs.json',
  );

  Uri songUri(String songId) {
    return Uri.https(
      'test-a2a77-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/songs/$songId.json',
    );
  }

  @override
  Future<List<Song>> fetchSongs({bool forceFetch = false}) async {
    // 1. Return cache if available
    if (!forceFetch && _cachedSongs != null) {
      return _cachedSongs!;
    }

    // 2. Otherwise fetch from API
    List<Song> songs = await _fetchSongsFromApi();

    // 3. Store in memory
    _cachedSongs = songs;

    return songs;
  }

  Future<List<Song>> _fetchSongsFromApi() async {
    final http.Response response = await http.get(songsUri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load songs');
    }

    if (response.body == 'null') {
      return [];
    }

    Map<String, dynamic> songJson = json.decode(response.body);

    List<Song> result = [];
    for (final entry in songJson.entries) {
      try {
        Map<String, dynamic> data = Map<String, dynamic>.from(entry.value);
        result.add(SongDto.fromJson(entry.key, data));
      } catch (_) {
        // Skip invalid song record
      }
    }

    return result;
  }

  @override
  Future<Song?> fetchSongById(String id) async {
    return null;
  }

  @override
  Future<void> likeSong(String songId, int currentLikes) async {
    final http.Response response = await http.patch(
      songUri(songId),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'likes': currentLikes + 1}),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Failed to like song');
    }

    if (_cachedSongs != null) {
      for (int i = 0; i < _cachedSongs!.length; i++) {
        Song song = _cachedSongs![i];
        if (song.id == songId) {
          _cachedSongs![i] = Song(
            id: song.id,
            title: song.title,
            artistId: song.artistId,
            duration: song.duration,
            imageUrl: song.imageUrl,
            likes: song.likes + 1,
          );
          break;
        }
      }
    }
  }
}
