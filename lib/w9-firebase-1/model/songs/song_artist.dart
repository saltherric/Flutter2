import '../artists/artist.dart';
import 'song.dart';

class SongArtist {
  final Song song;
  final Artist artist;

  SongArtist({required this.song, required this.artist});

  @override
  String toString() {
    return 'SongArtist(song: $song, artist: $artist)';
  }
}