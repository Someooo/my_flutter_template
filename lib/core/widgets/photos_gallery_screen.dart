// import 'index_indicator.dart';
// import 'package:flutter/material.dart';

// class PhotosGalleryScreen extends StatefulWidget {
//   final List<String> images;
//   final int initialIndex;


//   const PhotosGalleryScreen({
//     super.key,
//     required this.images,
//     required this.initialIndex,

//   });

//   @override
//   State<PhotosGalleryScreen> createState() => _PhotosGalleryScreenState();
// }

// class _PhotosGalleryScreenState extends State<PhotosGalleryScreen> {
//   late PageController _pageController;
//   late int _currentIndex;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: widget.initialIndex);
//     _currentIndex = widget.initialIndex;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.close,
//             color: Colors.white,
//           ),
//         ),
//       ),
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           PhotoViewGallery.builder(
//             itemCount: widget.images.length,
//             builder: (BuildContext context, int index) {
//               return PhotoViewGalleryPageOptions(
//                 imageProvider: NetworkImage(widget.images[index]),
//                 initialScale: PhotoViewComputedScale.contained,
//                 // heroAttributes: PhotoViewHeroAttributes(
//                 //   tag: {
//                 //     widget.images[index],
//                 //     widget.widgetKey
//                 //   },

//                 // ),
//               );
//             },
//             backgroundDecoration: const BoxDecoration(color: Colors.black),
//             pageController: _pageController,
//             scrollPhysics: const BouncingScrollPhysics(),
//             onPageChanged: (index) {
//               setState(() {
//                 _currentIndex = index;
//               });
//             },
//           ),
//           IndexIndicator(
//             currentIndex: _currentIndex,
//             totalItems: widget.images.length,
//           ),
//         ],
//       ),
//     );
//   }
// }
