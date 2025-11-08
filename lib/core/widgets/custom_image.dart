import '../../config/app_colors.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
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

  const CustomImage({
    super.key,
    required this.image,
    this.height = 50,
    this.width = 50,
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
    this.elevation, // New attribute
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

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: boxShadow != null ? [boxShadow] : null,
        gradient: gradient,
        color: backgroundColor,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            image,
            height: height,
            width: width,
            fit: fit,
            loadingBuilder: (context, child, progress) {
              if (progress == null) {
                return child;
              } else {
                final percentage = (progress.cumulativeBytesLoaded /
                        (progress.expectedTotalBytes ?? 1)) *
                    100;
                return Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: height,
                        width: width,
                        decoration: BoxDecoration(
                          color: SharedColors.greyTextColor,
                          borderRadius: borderRadius,
                          boxShadow: boxShadow != null ? [boxShadow] : null,
                          gradient: gradient,
                        ),
                      ),
                      CircularProgressIndicator(
                        value: percentage / 100,
                        strokeWidth: 4.0,
                      ),
                    ],
                  ),
                );
              }
            },
            errorBuilder: (context, error, stackTrace) {
              return noErrorHandler == true
                  ? const SizedBox.shrink()
                  : const Center(
                      child: Icon(
                        Icons.error,
                      ),
                    );
            },
          ),
          if (asDecoration)
            Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                gradient: gradient,
                color: backgroundColor,
              ),
            ),
        ],
      ),
    );
  }
}
