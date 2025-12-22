import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/common/chat/widgets/image_viewer_widget.dart';
import 'package:swoony/core/app_bar/common_app_bar.dart';
import 'package:swoony/core/component/image/common_image.dart';

class AllFileGird extends StatelessWidget {
  const AllFileGird({required this.files, super.key});

  final List<String> files;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(actions: []),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 8.w),
        child: _content(),
      ),
    );
  }

  GridView _content() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: files.length == 1 ? 1 : 2, // 2 items per row
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: files.length,
      itemBuilder: (context, index) {
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
