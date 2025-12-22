import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swoony/core/component/image/common_image.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/extensions/extension.dart';
// XFile class

class UploadFilesWidget extends StatelessWidget {
  const UploadFilesWidget({required this.files, required this.onRemove, super.key});
  final List<XFile> files;
  final Function(int index) onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8.w, left: 8.w, right: 8.w),
      decoration: BoxDecoration(
        color: getTheme.colorScheme.onSecondary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
        ),
        boxShadow: [BoxShadow(color: AppColors.disable, blurRadius: 1)],
      ),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: files.length,
        itemBuilder: (context, index) {
          final XFile file = files[index];
          final fileExtension = file.path.split('.').last;
          final bool isImage = fileExtension == 'png' || fileExtension == 'jpg';

          return Stack(
            clipBehavior: Clip.none, // Allow the icon to overflow the thumbnail
            children: [
              // Display either an image or file name
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: isImage
                    ? CommonImage(
                        imageSrc: file.path,
                        fill: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      )
                    : Center(
                        child: Text(
                          file.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.remove_circle, color: Colors.red),
                  onPressed: () {
                    // Trigger the removal of the file from the list
                    onRemove(index);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
