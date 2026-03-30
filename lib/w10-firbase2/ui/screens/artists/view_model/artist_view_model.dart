import 'package:flutter/material.dart';

import '../../../../data/repositories/artist/artist_repository.dart';
import '../../../../model/artist/artist.dart';
import '../../../../model/comment/comment.dart';
import '../../../../model/songs/song.dart';

class ArtistViewModel extends ChangeNotifier {
  final ArtistRepository artistRepository;
  final Artist artist;

  List<Song> songs = [];
  List<Comment> comments = [];

  bool isLoading = true;
  String? errorMessage;
  String? commentErrorMessage;

  ArtistViewModel({required this.artistRepository, required this.artist}) {
    fetchData();
  }

  Future<void> fetchData() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      songs = await artistRepository.fetchArtistSongs(artist.id);
      comments = await artistRepository.fetchArtistComments(artist.id);
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  Future<bool> addComment(String message) async {
    if (message.trim().isEmpty) {
      commentErrorMessage = 'Comment cannot be empty';
      notifyListeners();
      return false;
    }

    commentErrorMessage = null;

    try {
      Comment comment = await artistRepository.postArtistComment(
        artist.id,
        message.trim(),
      );
      comments = [comment, ...comments];
      notifyListeners();
      return true;
    } catch (e) {
      commentErrorMessage = 'Cannot post comment';
      notifyListeners();
      return false;
    }
  }

  void clearCommentError() {
    commentErrorMessage = null;
  }
}
