import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/theme.dart';
import '../../../widgets/song/song_tile.dart';
import '../view_model/artist_view_model.dart';
import 'comment_tile.dart';

class ArtistContent extends StatefulWidget {
  const ArtistContent({super.key});

  @override
  State<ArtistContent> createState() => _ArtistContentState();
}

class _ArtistContentState extends State<ArtistContent> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ArtistViewModel mv = context.watch<ArtistViewModel>();

    if (mv.commentErrorMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(mv.commentErrorMessage!)));
        mv.clearCommentError();
      });
    }

    if (mv.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (mv.errorMessage != null) {
      return Center(
        child: Text(
          'error = ${mv.errorMessage!}',
          style: TextStyle(color: Colors.red),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 16),
            Text(mv.artist.name, style: AppTextStyles.heading),
            SizedBox(height: 8),
            Text(mv.artist.genre, style: AppTextStyles.title),
            SizedBox(height: 24),

            Expanded(
              child: ListView(
                children: [
                  Text('Songs', style: AppTextStyles.title),
                  SizedBox(height: 8),
                  if (mv.songs.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('No songs for this artist yet.'),
                    )
                  else
                    ...mv.songs.map((song) => SongTile(song: song)),

                  SizedBox(height: 20),
                  Text('Comments', style: AppTextStyles.title),
                  SizedBox(height: 8),
                  if (mv.comments.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('No comments yet.'),
                    )
                  else
                    ...mv.comments.map(
                      (comment) => CommentTile(comment: comment),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: 'Write a comment',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () async {
                  String message = _commentController.text;
                  bool success = await mv.addComment(message);
                  if (success) {
                    _commentController.clear();
                  }
                },
                child: Text('Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
