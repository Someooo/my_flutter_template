// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../controllers/localization.controller.dart';
// import 'custom_text_widget.dart';

// class TranslationWidget extends StatelessWidget {
//   const TranslationWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () async {
//         // await Future.wait([
//         //   Get.updateLocale(
//         //     context.locale.languageCode == 'en' ? const Locale('ar') : const Locale('en'),
//         //   ),
//         //   context.setLocale(
//         //     context.locale.languageCode == 'en' ? const Locale('ar') : const Locale('en'),
//         //   ),
//         // ]);
//         // final locController = Get.find<LocalizationController>();
//         // final newLang = Get.locale?.languageCode == 'en' ? 'ar' : 'en';
//         //
//         // await locController.changeLanguage(newLang);
//         await Get.find<LocalizationController>().toggleLanguage();

//       },
//       child: Container(
//         height: 45.h,
//         width: 45.w,
//         alignment: Alignment.center,
//         // margin: EdgeInsets.symmetric(horizontal: 12.w),
//         // padding: EdgeInsets.all(8.r),
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: Colors.white,
//           ),
//           borderRadius: BorderRadius.circular(10.r),
//         ),
//         child: CustomTextWidget(
//           text: Get.locale?.languageCode == "en" ? "عربي" : "EN",
//           color: Colors.white,
//           isLocalize: false,

//         ),
//       ),
//     );
//   }
// }
