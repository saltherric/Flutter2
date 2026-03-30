import 'package:flutter/material.dart';
import '../../../../data/repositories/artist/artist_repository.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../model/artist/artist.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';
import '../../../utils/async_value.dart';
import 'library_item_data.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final ArtistRepository artistRepository;

  final PlayerState playerState;

  AsyncValue<List<LibraryItemData>> data = AsyncValue.loading();
  String? likeErrorMessage;

  LibraryViewModel({
    required this.songRepository,
    required this.playerState,
    required this.artistRepository,
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

  void fetchSong({bool forceFetch = false}) async {
    // 1- Loading state
    data = AsyncValue.loading();
    notifyListeners();

    try {
      // 1- Fetch songs
      List<Song> songs = await songRepository.fetchSongs(
        forceFetch: forceFetch,
      );

      // 2- Fethc artist
      List<Artist> artists = await artistRepository.fetchArtists(
        forceFetch: forceFetch,
      );

      // 3- Create the mapping artistid-> artist
      Map<String, Artist> mapArtist = {};
      for (Artist artist in artists) {
        mapArtist[artist.id] = artist;
      }

      List<LibraryItemData> data = songs
          .map(
            (song) =>
                LibraryItemData(song: song, artist: mapArtist[song.artistId]!),
          )
          .toList();

      this.data = AsyncValue.success(data);
    } catch (e) {
      // 3- Fetch is unsucessfull
      data = AsyncValue.error(e);
    }
    notifyListeners();
  }

  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();

  void clearLikeError() {
    likeErrorMessage = null;
  }

  void likeSong(LibraryItemData item) async {
    if (data.state != AsyncValueState.success) {
      return;
    }

    List<LibraryItemData> currentData = List.from(data.data!);
    int index = currentData.indexWhere((row) => row.song.id == item.song.id);

    if (index < 0) {
      return;
    }

    LibraryItemData row = currentData[index];
    Song updatedSong = Song(
      id: row.song.id,
      title: row.song.title,
      artistId: row.song.artistId,
      duration: row.song.duration,
      imageUrl: row.song.imageUrl,
      likes: row.song.likes + 1,
    );

    currentData[index] = LibraryItemData(song: updatedSong, artist: row.artist);

    data = AsyncValue.success(currentData);
    notifyListeners();

    try {
      await songRepository.likeSong(item.song.id, item.song.likes);
    } catch (e) {
      Song rollbackSong = Song(
        id: row.song.id,
        title: row.song.title,
        artistId: row.song.artistId,
        duration: row.song.duration,
        imageUrl: row.song.imageUrl,
        likes: row.song.likes,
      );

      currentData[index] = LibraryItemData(
        song: rollbackSong,
        artist: row.artist,
      );
      data = AsyncValue.success(currentData);
      likeErrorMessage = 'Cannot like song, try again';
      notifyListeners();
    }
  }
}
