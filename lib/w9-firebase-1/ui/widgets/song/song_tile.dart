import 'package:flutter/material.dart';

import '../../../model/songs/song_artist.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.songArtist,
    required this.isPlaying,
    required this.onTap,
  });

  final SongArtist songArtist;
  final bool isPlaying;
  final VoidCallback onTap;

  String get _durationText {
    int minutes = songArtist.song.duration.inMinutes;
    return '$minutes mins';
  }

  String get _artistText {
    return '${songArtist.artist.name} - ${songArtist.artist.genre}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          onTap: onTap,
          leading: CircleAvatar(
            backgroundImage: NetworkImage(songArtist.song.imageUrl.toString()),
            backgroundColor: Colors.grey[200],
          ),
          title: Text(songArtist.song.title),
          subtitle: Text('$_durationText  $_artistText'),
          trailing: Text(
            isPlaying ? "Playing" : "",
            style: TextStyle(color: Colors.amber),
          ),
        ),
      ),
    );
  }
}
