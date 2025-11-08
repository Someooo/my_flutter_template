// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'dart:ui' as ui;
// import '../../config/app_colors.dart';
// import '../utils/force_update_state.dart';
// import 'custom_text_widget.dart';

// class ForceUpdateScreen extends StatelessWidget {
//   final String message;

//   const ForceUpdateScreen({super.key, required this.message});

//   // Future<bool> _isHuaweiDevice() async {
//   //   if (!Platform.isAndroid) return false;
//   //
//   //   try {
//   //     final packageInfo = await PackageInfo.fromPlatform();
//   //     final installer = packageInfo.installerStore ?? '';
//   //
//   //     return installer == 'com.huawei.appmarket' ||
//   //         installer.toLowerCase().contains('huawei');
//   //   } catch (e) {
//   //     return false;
//   //   }
//   // }

//   Future<void> _openStore() async {
//     ForceUpdateState.setForceUpdateActive(false);

//     late final Uri url;
//     if (kIsWeb) {
//       // url = Uri.parse("https://www.asas4edu.com/");
//     } else if (Platform.isAndroid) {
//       // final isHuawei = await _isHuaweiDevice();
//       // if (isHuawei) {
//       //   // url = Uri.parse("https://appgallery.huawei.com/app/C114198491");
//       // } else {
//       url = Uri.parse(
//         "https://play.google.com/store/apps/details?id=iih.tpa.com&pli=1",
//       );
//       // }
//     } else if (Platform.isIOS) {
//       url = Uri.parse(
//           "https://apps.apple.com/us/app/%D8%A8%D9%8A%D8%AA-%D8%A7%D9%84%D8%AA%D8%A7%D9%85%D9%8A%D9%86/id6749091959");
//     }
//     // else if (Platform.isMacOS || Platform.isWindows) {
//     //   url = Uri.parse("https://www.asas4edu.com/my-app-promo");
//     // } else {
//     //   url = Uri.parse("https://www.asas4edu.com/");
//     // }
//     if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
//       throw Exception("Could not launch store link");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PopScope(
//         canPop: false,
//         child: BackdropFilter(
//           filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//           child: Dialog(
//             backgroundColor: Colors.transparent,
//             child: Container(
//               width: 300,
//               padding: const EdgeInsets.all(24.0),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(
//                   color: Get.theme.colorScheme.primary,
//                   width: 0.4,
//                 ),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Icon(Icons.system_update, size: 100, color: Colors.red),
//                   const SizedBox(height: 24),
//                   const CustomTextWidget(text: "UpdateRequired", fontSize: 20),
//                   const SizedBox(height: 16),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: _openStore,
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 32,
//                           vertical: 12,
//                         ),
//                       ),
//                       child: const CustomTextWidget(
//                         text: 'UpdateNow',
//                         color: AppLightColors.primaryColor,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
