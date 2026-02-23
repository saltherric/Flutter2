import 'package:flutter/material.dart';
import 'package:flutter2/2_download_app/ui/screens/downloads/widgets/download_tile.dart';
import '../../theme/theme.dart';
import '../../../main.dart';
import 'widgets/download_controler.dart';

class DownloadsScreen extends StatelessWidget {
  final List<Ressource> ressources = [
    Ressource(name: "image1.png", size: 120),
    Ressource(name: "image1.png", size: 500),
    Ressource(name: "image3.png", size: 12000),
  ];

  final List<DownloadController> controllers = [];

  DownloadsScreen({super.key}) {
    for (Ressource ressource in ressources) {
      controllers.add(DownloadController(ressource));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeColorProvider,
      builder: (context, child) {
        final theme = themeColorProvider.currentThemeColor;

        return Container(
          color: theme.backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Text(
                "Downloads",
                style: AppTextStyles.heading.copyWith(color: theme.color),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: ListView.builder(
                  itemCount: controllers.length,
                  itemBuilder: (context, index) {
                    return DownloadTile(controller: controllers[index]);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
