import 'package:flutter/material.dart';
import '../../../providers/theme_color_provider.dart';
import '../../../../main.dart';
import '../../../theme/theme.dart';
import 'download_controler.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        final theme = themeColorProvider.currentThemeColor;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.greyLight),
          ),
          child: Row(
            children: [
              Icon(
                Icons.insert_drive_file,
                size: 40,
                color: AppColors.iconNormal,
              ),

              const SizedBox(width: 16),

              // text area
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.ressource.name,
                      style: AppTextStyles.body.copyWith(color: AppColors.text),
                    ),
                    const SizedBox(height: 8),

                    if (controller.status == DownloadStatus.downloading) ...[
                      LinearProgressIndicator(
                        value: controller.progress,
                        color: theme.color,
                        backgroundColor: AppColors.greyLight,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "${(controller.progress * 100).toInt()}%",
                        style: AppTextStyles.label.copyWith(
                          color: AppColors.textLight,
                        ),
                      ),
                    ] else ...[
                      Text(
                        controller.status == DownloadStatus.downloaded
                            ? "Downloaded"
                            : "${controller.ressource.size} MB",
                        style: AppTextStyles.label.copyWith(
                          color: AppColors.textLight,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),

              // action button area
              _buildAction(theme),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAction(ThemeColor theme) {
    if (controller.status == DownloadStatus.notDownloaded) {
      return ElevatedButton(
        onPressed: controller.startDownload,
        child: const Icon(Icons.download),
      );
    }

    if (controller.status == DownloadStatus.downloading) {
      return SizedBox(
        width: 28,
        height: 28,
        child: Icon(Icons.downloading),
      );
    }

    return Icon(Icons.file_download_done, size: 30);
  }
}
