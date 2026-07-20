import 'package:flutter/material.dart';

import 'skeleton_card_widget.dart';

class CatalogLoadingWidget extends StatefulWidget {
  const CatalogLoadingWidget({super.key});

  @override
  State<CatalogLoadingWidget> createState() => _CatalogLoadingWidgetState();
}

class _CatalogLoadingWidgetState extends State<CatalogLoadingWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final base = colorScheme.onSurface.withValues(alpha: 0.08);
    final highlight = colorScheme.onSurface.withValues(alpha: 0.18);

    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, _) {
        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.68,
          ),
          itemCount: _kSkeletonCardCount,
          itemBuilder: (context, _) => SkeletonCardWidget(
            progress: _shimmerController.value,
            base: base,
            highlight: highlight,
          ),
        );
      },
    );
  }
}

const int _kSkeletonCardCount = 8;
