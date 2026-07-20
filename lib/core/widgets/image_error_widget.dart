import 'package:flutter/material.dart';

/// Reusable widget for displaying a clean, user-friendly error state when an image fails to load.
class ImageErrorWidget extends StatelessWidget {
  const ImageErrorWidget({
    super.key,
    this.message = 'Please check your internet connection',
    this.icon = Icons.wifi_off_rounded,
    this.borderRadius,
  });

  final String message;
  final IconData icon;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: borderRadius,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 26,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
            ),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodySmall?.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
