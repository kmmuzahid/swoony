import 'package:flutter/material.dart';
import 'package:swoony/common/chat/widgets/all_file_gird.dart';
import 'package:swoony/common/chat/widgets/image_viewer_widget.dart';
import 'package:swoony/core/component/image/common_image.dart';

class FileThumbnailGrid extends StatelessWidget {
  const FileThumbnailGrid({required this.files, super.key});
  final List<String> files;

  @override
  Widget build(BuildContext context) {
    // Determine how many thumbnails to show
    final int visibleFilesCount = files.length > 3 ? 3 : files.length;
    final List<String> remainingFiles = files.length > 3 ? files.sublist(3) : [];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: files.length == 1 ? 1 : 2, // 2 items per row
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: visibleFilesCount + (remainingFiles.isNotEmpty ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < visibleFilesCount) {
          // Normal thumbnail for the first 4 files
          final file = files[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FullScreenImageViewer(imagePath: file)),
              );
            },
            child: _buildThumbnail(file),
          );
        } else {
          // Show a "More" thumbnail if there are extra files
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => AllFileGird(files: files)));
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                _buildThumbnail(files[index]),
                Container(color: Colors.black45),
                Center(
                  child: Text(
                    '+${remainingFiles.length}',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildThumbnail(String file) {
    final bool isImage = file.endsWith('png') || file.endsWith('jpg');
    return isImage
        ? CommonImage(imageSrc: file, fill: BoxFit.cover)
        : Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                file.split('/').last,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black, fontSize: 12),
              ),
            ),
          );
  }
}
