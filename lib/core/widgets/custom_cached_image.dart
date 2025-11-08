import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter/material.dart';

class CustomCachedImage extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final bool isNotification;
  final String placeholder;
  final bool? noPlaceHolder;
  final bool? noErrorHandler;
  final bool? largePlaceErrorScale;
  final bool asDecoration;

  // New attribute for elevation
  final double? elevation;

  // Decoration properties
  final BorderRadiusGeometry? borderRadius;
  final Gradient? gradient;
  final Color? backgroundColor;

  const CustomCachedImage({
    super.key,
    required this.image,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.isNotification = false,
    this.placeholder = '',
    this.noPlaceHolder,
    this.noErrorHandler,
    this.largePlaceErrorScale,
    this.asDecoration = false,
    this.borderRadius,
    this.gradient,
    this.backgroundColor,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    // Define the BoxShadow based on the elevation
    BoxShadow? boxShadow;
    if (elevation != null) {
      boxShadow = BoxShadow(
        color: Colors.black.withValues(alpha: 0.3),
        spreadRadius: elevation! / 2,
        blurRadius: elevation!,
        offset: Offset(0, elevation! / 2),
      );
    }

    return CacheNetworkImagePlus(
      imageUrl: image,
      imageBuilder: (context, imageProvider) {
        if (asDecoration) {
          return Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              boxShadow: boxShadow != null ? [boxShadow] : null,
              gradient: gradient,
              color: backgroundColor,
              image: DecorationImage(
                image: imageProvider,
                fit: fit,
              ),
            ),
          );
        } else {
          return Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              boxShadow: boxShadow != null ? [boxShadow] : null,
            ),
            child: Image(
              image: imageProvider,
              height: height,
              width: width,
              fit: fit,
            ),
          );
        }
      },
      errorWidget: noErrorHandler == true
          ? const SizedBox.shrink()
          : const Center(
              child: Icon(
                Icons.error,
              ),
            ),
    );
  }
}
