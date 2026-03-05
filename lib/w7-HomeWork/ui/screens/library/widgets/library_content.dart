import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/songs/song.dart';
import '../../../states/settings_state.dart';
import '../../../theme/theme.dart';
import '../view_model/library_view_model.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LibraryViewModel>();
    final settingsState = context.watch<AppSettingsState>();

    return Container(
      color: settingsState.theme.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Text("Library", style: AppTextStyles.heading),

          const SizedBox(height: 50),

          Expanded(
            child: ListView.builder(
              itemCount: viewModel.songs.length,
              itemBuilder: (context, index) {
                Song song = viewModel.songs[index];

                return ListTile(
                  title: Text(song.title),

                  trailing: Text(
                    viewModel.currentSong == song ? "Playing" : "",
                    style: const TextStyle(color: Colors.amber),
                  ),

                  onTap: () {
                    viewModel.playSong(song);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
