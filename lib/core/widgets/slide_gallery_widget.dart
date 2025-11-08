import 'custom_image.dart';
import 'package:flutter/material.dart';

class SlideGalleryWidget extends StatefulWidget {
  final List<String>? images;
  const SlideGalleryWidget({super.key, required this.images});

  @override
  State<SlideGalleryWidget> createState() => _SlideGalleryWidgetState();
}

class _SlideGalleryWidgetState extends State<SlideGalleryWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.images == null) {
      return const SizedBox.shrink();
    }
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 200),
      child: CarouselView(
        itemExtent: MediaQuery.of(context).size.width * 0.8,
        itemSnapping: true,
        shrinkExtent: 200,
        children: widget.images!.map((img) {
          return Center(
            child: CustomImage(image: img),
          );
        }).toList(),
      ),
    );
  }
}
