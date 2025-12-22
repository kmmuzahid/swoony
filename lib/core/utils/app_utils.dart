import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:swoony/common/auth/cubit/auth_cubit.dart';
import 'package:swoony/common/auth/cubit/auth_state.dart';
import 'package:swoony/common/auth/model/user_login_info_model.dart';
import 'package:swoony/core/component/other_widgets/permission_handler_helper.dart';
import 'package:swoony/core/config/route/app_router.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:permission_handler/permission_handler.dart';

class Utils {
  static late Size deviceSize;



  static RepaintBoundary divider() => RepaintBoundary(
    child: Divider(color: AppColors.greay100, thickness: 1.w),
  );

  static Role? getRole() =>
      appRouter.navigatorKey.currentState!.context.read<AuthCubit>().state.userLoginInfoModel.role;

  static DateTime? parseDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return null;
    }
    return DateTime.tryParse(dateString);
  }


  static DateTime subtractYears(DateTime date, int yearsToSubtract) {
    // Handle edge case for leap year (Feb 29 to non-leap year)
    int newYear = date.year - yearsToSubtract;
    int newMonth = date.month;
    int newDay = date.day;

    // Check if the resulting date would be invalid (e.g., Feb 29 to non-leap year)
    // Dart automatically corrects this to Feb 28 if the new year is not a leap year
    DateTime newDate;
    try {
      newDate = DateTime(
        newYear,
        newMonth,
        newDay,
        date.hour,
        date.minute,
        date.second,
        date.millisecond,
        date.microsecond,
      );
    } catch (e) {
      // Fallback: if invalid date, set day to last valid day of the month
      newDate = DateTime(
        newYear,
        newMonth + 1,
        0,
        date.hour,
        date.minute,
        date.second,
        date.millisecond,
        date.microsecond,
      );
    }
    return newDate;
  }

  static String formatDateTimeToHms(DateTime dateTime) {
    final localDate = dateTime.toLocal();
    final hours = localDate.hour.toString().padLeft(2, '0');
    final minutes = localDate.minute.toString().padLeft(2, '0');
    final seconds = localDate.second.toString().padLeft(2, '0');

    return '$hours:$minutes:$seconds';
  }

  static String formatDurationToHms(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

    return '$hours:$minutes:$seconds';
  }

  static String formatTime(DateTime time) {
    return DateFormat.jm().format(time.toLocal()); // 'jm' = e.g., 8:00 PM
  }

  static String formatDateTimeWithSHortMonth(DateTime dateTime) {
    final localDate = dateTime.toLocal();
    final hours = (localDate.hour % 12).toString().padLeft(2, '0');
    final minutes = localDate.minute.toString().padLeft(2, '0');
    final amPm = localDate.hour < 12 ? 'AM' : 'PM';

    final shortMonth = DateFormat('MMM').format(localDate);
    final day = DateFormat('d').format(localDate);

    final shortDay = DateFormat('E').format(localDate).substring(0, 3);
    return '$day $shortMonth $shortDay $hours:$minutes $amPm';
  }

  static String formatDateToShortMonth(DateTime dateTime) {
    final localDate = dateTime.toLocal();
    const List<String> monthAbbr = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final String day = localDate.day.toString().padLeft(2, '0');
    final String month = monthAbbr[localDate.month - 1];
    final String year = localDate.year.toString();

    return '$day $month $year';
  }

  static String formatDateTime(DateTime dateTime) {
    final dateFormat = DateFormat('MMM dd, h:mm a');
    return dateFormat.format(dateTime.toLocal());
  }

  static String formatDouble(double value) {
    final double rounded = double.parse(value.toStringAsFixed(1));
    if (rounded == rounded.toInt()) {
      return rounded.toInt().toString();
    } else {
      return rounded.toStringAsFixed(1);
    }
  }
}

String sampleHtmlDetails = '''<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Description Replication</title>
    <!-- Load Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Custom configuration for Inter font -->

</head>
<body class="flex items-center justify-center min-h-screen p-4">

    <!-- Container matching the gray background and width from the image -->
    <div class="w-full max-w-2xl p-6 md:p-8">

        <!-- Replication Block 1 -->
        <div class="mb-8">
            <!-- Header font size changed from text-xl (20px) to text-lg (18px) -->
            <h2 class="text-lg font-bold text-gray-900 mb-2">Event Description</h2>
            <!-- Body font size is text-base (16px) -->
            <p class="text-gray-700">
                A casual yet insightful gathering for designers, creators, and digital thinkers to connect, share stories, and explore the future of design. Join us for a day filled with inspiring talks, interactive sessions, and networking with local talents from the creative industry. Join us for a day filled with inspiring talks, interactive sessions, and networking with local talents from the creative industry.
            </p>
        </div>

        <!-- Replication Block 2 -->
        <div class="mb-8">
            <!-- Header font size changed from text-xl (20px) to text-lg (18px) -->
            <h2 class="text-lg font-bold text-gray-900 mb-2">Event Description</h2>
            <!-- Body font size is text-base (16px) -->
            <p class="text-gray-700">
                A casual yet insightful gathering for designers, creators, and digital thinkers to connect, share stories, and explore the future of design. Join us for a day filled with inspiring talks, interactive sessions, and networking with local talents from the creative industry. Join us for a day filled with inspiring talks, interactive sessions, and networking with local talents from the creative industry.
            </p>
        </div>

        <!-- Replication Block 3 -->
        <div class="mb-0">
            <!-- Header font size changed from text-xl (20px) to text-lg (18px) -->
            <h2 class="text-lg font-bold text-gray-900 mb-2">Event Description</h2>
            <!-- Body font size is text-base (16px) -->
            <p class="text-gray-700">
                A casual yet insightful gathering for designers, creators, and digital thinkers to connect, share stories, and explore the future of design. Join us for a day filled with inspiring talks, interactive sessions, and networking with local talents from the creative industry.
            </p>
        </div>

    </div>

</body>
</html>
''';
