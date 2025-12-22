// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:swoony/core/component/image/common_image.dart';
// import 'package:swoony/core/component/text/common_text.dart';
// import 'package:swoony/core/config/languages/cubit/language_cubit.dart';
// import 'package:swoony/core/utils/constants/app_colors.dart';
// import 'package:swoony/core/utils/constants/app_text_styles.dart';
// import 'package:swoony/core/utils/extensions/extension.dart';
// import 'package:swoony/core/utils/log/app_log.dart';

// class EventWidget extends StatelessWidget {
//   const EventWidget({
//     required this.image,
//     this.title = 'Juice WRLD Mon. Jan. 12, 8pm Eko Hotel & Suites Pre Order available Nov. 1',
//     required this.onTap,
//     super.key,
//   });
//   final String image;
//   final String title;
//   final Function() onTap;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           Expanded(
//             child: Stack(
//               children: [
//                 Positioned.fill(child: CommonImage(imageSrc: image, borderRadius: 12)),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: AppColors.primaryText.withValues(alpha: 0.5),
//                     borderRadius: BorderRadius.circular(12.r),
//                   ),
//                 ),
//                 Align(
//                   child: CommonText(
//                     text: title,
//                     left: 10,
//                     right: 10,
//                     fontSize: 16.5,
//                     maxLines: 7,
//                     autoResize: false,
//                     textAlign: TextAlign.left,
//                     style: AppTextStyles.titleMedium?.copyWith(color: AppColors.textWhite),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           CommonText(
//             text: AppString.morePlus,
//             fontSize: 18,
//             style: AppTextStyles.titleLarge?.copyWith(color: AppColors.primaryColor),
//           ).start,
//         ],
//       ),
//     );
//   }
// }
