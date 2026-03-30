import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/artist/artist.dart';
import '../../../model/comment/comment.dart';
import '../../../model/songs/song.dart';
import '../../dtos/artist_dto.dart';
import '../../dtos/comment_dto.dart';
import '../../dtos/song_dto.dart';
import 'artist_repository.dart';

class ArtistRepositoryFirebase implements ArtistRepository {
  List<Artist>? _cachedArtists;

  final Uri artistsUri = Uri.https(
    'test-a2a77-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/artists.json',
  );

  final Uri songsUri = Uri.https(
    'test-a2a77-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/songs.json',
  );

  Uri artistCommentsUri(String artistId) {
    return Uri.https(
      'test-a2a77-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/comments/$artistId.json',
    );
  }

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

  @override
  Future<List<Song>> fetchArtistSongs(String artistId) async {
    final http.Response response = await http.get(songsUri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load artist songs');
    }

    if (response.body == 'null') {
      return [];
    }

    Map<String, dynamic> songJson = json.decode(response.body);

    List<Song> result = [];
    for (final entry in songJson.entries) {
      try {
        Map<String, dynamic> data = Map<String, dynamic>.from(entry.value);
        Song song = SongDto.fromJson(entry.key, data);
        if (song.artistId == artistId) {
          result.add(song);
        }
      } catch (_) {
        // Skip invalid song record
      }
    }

    return result;
  }

  @override
  Future<List<Comment>> fetchArtistComments(String artistId) async {
    final http.Response response = await http.get(artistCommentsUri(artistId));

    if (response.statusCode != 200) {
      throw Exception('Failed to load artist comments');
    }

    if (response.body == 'null') {
      return [];
    }

    Map<String, dynamic> commentJson = json.decode(response.body);

    List<Comment> result = [];
    for (final entry in commentJson.entries) {
      try {
        Map<String, dynamic> data = Map<String, dynamic>.from(entry.value);
        result.add(CommentDto.fromJson(entry.key, artistId, data));
      } catch (_) {
        // Skip invalid comment record
      }
    }

    return result;
  }

  @override
  Future<Comment> postArtistComment(String artistId, String message) async {
    Map<String, dynamic> payload = {
      CommentDto.messageKey: message,
      CommentDto.createdAtKey: DateTime.now().toIso8601String(),
    };

    final http.Response response = await http.post(
      artistCommentsUri(artistId),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payload),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Failed to post comment');
    }

    Map<String, dynamic> data = json.decode(response.body);
    String commentId = data['name'];

    return CommentDto.fromJson(commentId, artistId, payload);
  }
}
