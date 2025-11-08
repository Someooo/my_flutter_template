// import 'custom_image.dart';
// import 'photos_gallery_screen.dart';
// import 'package:flutter/material.dart';

// class GalleryWidget extends StatefulWidget {
//   final List<String>? images;

//   const GalleryWidget({
//     super.key,
//     required this.images,
//   });

//   @override
//   State<GalleryWidget> createState() => _GalleryWidgetState();
// }

// class _GalleryWidgetState extends State<GalleryWidget> {
//   void _showImageGallery(int initialIndex) {
//     if (widget.images == null || widget.images!.isEmpty) return;

//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (_) => PhotosGalleryScreen(
//           images: widget.images!,
//           initialIndex: initialIndex,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final List<Widget> mediaWidgets = [];

//     if (widget.images != null && widget.images!.isNotEmpty) {
//       for (int i = 0; i < widget.images!.length; i++) {
//         mediaWidgets.add(
//           GestureDetector(
//             onTap: () => _showImageGallery(i),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(20),
//               child: CustomImage(
//                 image: widget.images![i],
//                 fit: BoxFit.cover,
//                 height: 150,
//                 width: 150,
//               ),
//             ),
//           ),
//         );
//       }
//     }

//     if (mediaWidgets.isEmpty) {
//       return const SizedBox.shrink();
//     }

//     return GridView.builder(
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       padding: const EdgeInsets.all(8.0),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         mainAxisSpacing: 8,
//         crossAxisSpacing: 8,
//       ),
//       itemCount: mediaWidgets.length,
//       itemBuilder: (context, index) {
//         return mediaWidgets[index];
//       },
//     );
//   }
// }
