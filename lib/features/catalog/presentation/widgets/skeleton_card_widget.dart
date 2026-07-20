import 'package:flutter/material.dart';

class SkeletonCardWidget extends StatelessWidget {
  const SkeletonCardWidget({
    super.key,
    required this.progress,
    required this.base,
    required this.highlight,
  });

  final double progress;
  final Color base;
  final Color highlight;

  @override
  Widget build(BuildContext context) {
    final shimmerGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [base, highlight, base],
      stops: [
        (progress - 0.3).clamp(0.0, 1.0),
        progress.clamp(0.0, 1.0),
        (progress + 0.3).clamp(0.0, 1.0),
      ],
    );

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: ShaderMask(
        shaderCallback: (bounds) => shimmerGradient.createShader(bounds),
        blendMode: BlendMode.srcATop,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: double.infinity,
                color: base,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 14,
                    width: 60,
                    decoration: BoxDecoration(
                      color: base,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(height: 13, color: base),
                  const SizedBox(height: 4),
                  Container(height: 13, width: 80, color: base),
                  const SizedBox(height: 8),
                  Container(
                    height: 16,
                    width: 56,
                    decoration: BoxDecoration(
                      color: base,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
