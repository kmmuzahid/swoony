import 'package:flutter/material.dart';
import 'package:swoony/core/component/image/common_image.dart';

class FullScreenImageViewer extends StatelessWidget {
  const FullScreenImageViewer({required this.imagePath, super.key});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Make background black for image view
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 0,
        leading: const SizedBox(),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Center(
        child: InteractiveViewer(
          panEnabled: true, // Allow panning
          scaleEnabled: true, // Allow zooming
          child: CommonImage(
            imageSrc: imagePath, // Load the image from the path
            fill: BoxFit.contain, // Keep aspect ratio intact
          ),
        ),
      ),
    );
  }
}
