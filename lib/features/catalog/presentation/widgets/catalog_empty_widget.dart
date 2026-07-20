import 'package:flutter/material.dart';

import '../controllers/catalog_controller.dart';

class CatalogEmptyWidget extends StatelessWidget {
  const CatalogEmptyWidget({super.key, required this.controller});

  final CatalogController controller;

  bool get _hasActiveFilters =>
      controller.searchQuery.isNotEmpty ||
      controller.selectedCategory.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 64,
              color: colorScheme.onSurface.withValues(alpha: 0.25),
            ),
            const SizedBox(height: 20),
            Text(
              'No products found',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try changing your search or filters.',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.5),
              ),
              textAlign: TextAlign.center,
            ),
            if (_hasActiveFilters) ...[
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  controller.clearFilters();
                },
                icon: const Icon(Icons.filter_alt_off_rounded, size: 18),
                label: const Text('Clear Filters'),
              ),
            ],

          ],
        ),
      ),
    );
  }
}
