import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
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
  Future<List<Song>> fetchSongs() async {
    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      if (response.body == 'null') {
        return [];
      }

      // 1 - Read all songs from firebase
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
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load songs');
    }
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
  }
}
