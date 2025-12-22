import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swoony/core/component/other_widgets/permission_handler_helper.dart';
import 'package:swoony/core/config/route/app_router.dart';
import 'package:permission_handler/permission_handler.dart';
import '../constants/app_colors.dart';

class OtherHelper {
  static ImagePicker picker = ImagePicker();
  static Future<String> openDatePickerDialog(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      builder: (context, child) => Theme(
        data: Theme.of(
          context,
        ).copyWith(colorScheme: ColorScheme.light(primary: AppColors.primaryColor)),
        child: child!,
      ),
      context: appRouter.navigatorKey.currentState!.context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      controller.text = '${picked.year}/${picked.month}/${picked.day}';
      return picked.toIso8601String();
    }
    return '';
  }

  // static Future<String?> openGallery() async {

  //   final XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
  //   return image?.path;
  // }

  static Future<XFile?> openGallery() async {
    final status = await const PermissionHandlerHelper(permission: Permission.photos).getStatus();
    if (status == false) return null;
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
 
    return pickedFile;
  }

  static Future<String?> pickVideoFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);
    return video?.path;
  }

  static Future<String?> openCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    return image?.path;
  }

  static Future<String> openTimePickerDialog(TextEditingController? controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: appRouter.navigatorKey.currentState!.context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      final String formattedTime = _formatTime(picked);
      controller?.text = formattedTime;
      return formattedTime;
    }
    return '';
  }

  static String _formatTime(TimeOfDay time) {
    return "${time.hour > 12 ? (time.hour - 12).toString().padLeft(2, '0') : (time.hour == 0 ? 12 : time.hour).toString().padLeft(2, '0')}:"
        "${time.minute.toString().padLeft(2, '0')} ${time.hour >= 12 ? "PM" : "AM"}";
  }
}
