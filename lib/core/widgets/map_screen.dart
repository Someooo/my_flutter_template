// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../config/app_colors.dart';
// import '../utils/utils.dart';
// import 'custom_text_widget.dart';
// import 'custom_cached_image.dart';
// import '../utils/app_text_style.dart';

// class MapScreen extends StatelessWidget {
//   final double latitude;
//   final double longitude;
//   final String? address;
//   final double? height;
//   final double? width;

//   const MapScreen({
//     super.key,
//     required this.latitude,
//     required this.longitude,
//     this.address,
//     this.height,
//     this.width,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final LatLng location = LatLng(latitude, longitude);
    
//     return Container(
//       height: height ?? 200.h,
//       width: width ?? double.infinity,
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(12),
//         child: Column(
//           children: [
//             // Map Header
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(12),
//                   topRight: Radius.circular(12),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Icon(
//                     Icons.location_on,
//                     color: Colors.red,
//                     size: 20.sp,
//                   ),
//                   const SizedBox(width: 8),
//                 Expanded(
//                     child: CustomTextWidget(
//                       text: 'location',
//                       textstyle: AppTextStyle.headLine3,
                    
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () => _openGoogleMaps(latitude, longitude),
//                     borderRadius: BorderRadius.circular(6),
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
                    
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(
//                             Icons.open_in_new,
//                             color:AppLightColors.primaryColor,
//                             size: 15.sp,
//                           ),
//                           const SizedBox(width: 4),
//                           CustomTextWidget(
//                             text: 'openInMaps',
//                             color:AppLightColors.primaryColor,
//                             fontSize: Responsive.isTablet? 5.sp : 14.sp,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            
//             Expanded(
//               child: GestureDetector(
//                 onTap: () => _openGoogleMaps(latitude, longitude),
//                 child: Container(
//                   color: Colors.grey.shade100,
//                   child: FlutterMap(
//                     options: MapOptions(
//                       initialCenter: location,
//                       initialZoom: 15.0,
//                       interactionOptions: const InteractionOptions(
//                         flags: InteractiveFlag.pinchZoom | 
//                                InteractiveFlag.drag,
//                       ),
//                     ),
//                     children: [
//                       TileLayer(
//                         urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                         userAgentPackageName: 'com.example.insurance_app',
//                         maxZoom: 18,
//                       ),
//                       MarkerLayer(
//                         markers: [
//                           Marker(
//                             point: location,
//                             width: 40,
//                             height: 40,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.red,
//                                 shape: BoxShape.circle,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.red.withOpacity(0.3),
//                                     spreadRadius: 2,
//                                     blurRadius: 8,
//                                     offset: const Offset(0, 2),
//                                   ),
//                                 ],
//                               ),
//                               child: const Icon(
//                                 Icons.location_pin,
//                                 color: Colors.white,
//                                 size: 24,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
            
//             if (address != null && address!.isNotEmpty)
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: const BorderRadius.only(
//                     bottomLeft: Radius.circular(12),
//                     bottomRight: Radius.circular(12),
//                   ),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(
//                       Icons.info_outline,
//                       color: Colors.grey.shade600,
//                       size: 16.sp,
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: CustomTextWidget(
//                         text: address!,
//                         textstyle: AppTextStyle.subTitle4,
                       
//                         maxLines: 2,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _openGoogleMaps(double lat, double lng) async {
//     final Uri googleMapsUri = Uri.parse(
//       'https://www.google.com/maps/search/?api=1&query=$lat,$lng'
//     );
    
//     final Uri appleMapsUri = Uri.parse(
//       'http://maps.apple.com/?q=$lat,$lng'
//     );

//     try {
//       // Try to launch Google Maps first
//       if (await canLaunchUrl(googleMapsUri)) {
//         await launchUrl(
//           googleMapsUri,
//           mode: LaunchMode.externalApplication,
//         );
//       } else if (await canLaunchUrl(appleMapsUri)) {
//         await launchUrl(
//           appleMapsUri,
//           mode: LaunchMode.externalApplication,
//         );
//       } else {
//         final Uri fallbackUri = Uri.parse(
//           'geo:$lat,$lng?q=$lat,$lng'
//         );
//         if (await canLaunchUrl(fallbackUri)) {
//           await launchUrl(
//             fallbackUri,
//             mode: LaunchMode.externalApplication,
//           );
//         }
//       }
//     } catch (e) {
//       debugPrint('Error opening maps: $e');
//     }
//   }
// }
