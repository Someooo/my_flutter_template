import 'custom_image.dart';
import 'package:flutter/material.dart';

class CustomAvataWidget extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;

  const CustomAvataWidget({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: imageUrl == ""
          ? const SizedBox.shrink()
          : CustomImage(image: imageUrl),
    );
  }
}
