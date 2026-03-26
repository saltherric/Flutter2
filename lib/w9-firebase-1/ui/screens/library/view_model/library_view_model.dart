import 'package:flutter/material.dart';
import '../../../../data/repositories/artists/artist_repository.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../model/artists/artist.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';
import '../../../../model/songs/song_artist.dart';
import '../../../utils/async_value.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final ArtistRepository artistRepository;
  final PlayerState playerState;

  AsyncValue<List<SongArtist>> songsValue = AsyncValue.loading();

  LibraryViewModel({
    required this.songRepository,
    required this.artistRepository,
    required this.playerState,
  }) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    fetchSong();
  }

  void fetchSong() async {
    // 1- Loading state
    songsValue = AsyncValue.loading();
    notifyListeners();

    try {
      // 2- Fetch is successfull
      List<Song> songs = await songRepository.fetchSongs();
      List<Artist> artists = await artistRepository.fetchArtists();

      List<SongArtist> songsArtists = [];

      for (Song song in songs) {
        for (Artist artist in artists) {
          if (song.artistId == artist.id) {
            songsArtists.add(SongArtist(song: song, artist: artist));
            break;
          }
        }
      }

      songsValue = AsyncValue.success(songsArtists);
    } catch (e) {
      // 3- Fetch is unsucessfull
      songsValue = AsyncValue.error(e);
    }

    notifyListeners();
  }

  bool isSongPlaying(SongArtist songArtist) =>
      playerState.currentSong == songArtist.song;

  void start(SongArtist songArtist) => playerState.start(songArtist.song);
  void stop(SongArtist songArtist) => playerState.stop();
}
