import 'package:flutter/material.dart';

import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../model/songs/song.dart';
import '../../../states/player_state.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;

  List<Song> _songs = [];

  LibraryViewModel({required this.songRepository, required this.playerState});

  void init() {
    _songs = songRepository.fetchSongs();

    // listen player changes
    playerState.addListener(() {
      notifyListeners();
    });
  }

  List<Song> get songs => _songs;

  Song? get currentSong => playerState.currentSong;

  void playSong(Song song) {
    playerState.start(song);
  }
}
