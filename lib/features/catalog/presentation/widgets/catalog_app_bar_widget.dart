import 'package:flutter/material.dart';

class CatalogAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const CatalogAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: colorScheme.surface,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Catalog Browser',
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            'Browse 2,000 Products',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.55),
              fontSize: 11,
            ),
          ),
        ],
      ),
      actions: const [
        IconButton(
          icon: Icon(Icons.shopping_bag_outlined),
          tooltip: 'Cart',
          onPressed: null,
        ),
        SizedBox(width: 4),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 8);
}
