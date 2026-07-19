import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/catalog_controller.dart';
import '../widgets/category_filter_widget.dart';
import '../widgets/product_card_widget.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/summary_card_widget.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CatalogController>();

    return Scaffold(
      appBar: const _CatalogAppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Obx(
                () => SummaryCardWidget(
                  favoriteCount: controller.favoriteCount,
                  favoriteTotalPrice: controller.favoriteTotalPrice,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SearchBarWidget(
                onChanged: controller.onSearchChanged,
              ),
            ),
            const SizedBox(height: 8),
            Obx(
              () => CategoryFilterWidget(
                categories: ['All', ...controller.categories],
                selectedCategory: controller.selectedCategory,
                onCategorySelected: controller.onCategorySelected,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Obx(() => _buildBody(controller)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(CatalogController controller) {
    if (controller.isLoading) {
      return const _LoadingView();
    }

    if (controller.errorMessage != null) {
      return _ErrorView(
        message: controller.errorMessage!,
        onRetry: controller.loadProducts,
      );
    }

    if (controller.isEmpty) {
      return _EmptyView(controller: controller);
    }

    return _ProductGrid(controller: controller);
  }
}

class _CatalogAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CatalogAppBar();

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
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_bag_outlined),
          tooltip: 'Cart',
          onPressed: null,
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 8);
}

class _ProductGrid extends StatelessWidget {
  const _ProductGrid({required this.controller});

  final CatalogController controller;

  @override
  Widget build(BuildContext context) {
    final products = controller.filteredProducts;

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.68,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Obx(
          () => ProductCardWidget(
            productId: product.id,
            name: product.name,
            category: product.category,
            price: product.price,
            imageUrl: product.imageUrl,
            isFavorite: controller.isFavorite(product.id),
            onFavoriteTap: () => controller.toggleFavorite(product.id),
          ),
        );
      },
    );
  }
}

class _LoadingView extends StatefulWidget {
  const _LoadingView();

  @override
  State<_LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<_LoadingView>
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
          itemBuilder: (context, _) => _SkeletonCard(
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

class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard({
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
                  // Product name rows
                  Container(height: 13, color: base),
                  const SizedBox(height: 4),
                  Container(height: 13, width: 80, color: base),
                  const SizedBox(height: 8),
                  // Price row
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

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

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
              Icons.wifi_off_rounded,
              size: 64,
              color: colorScheme.error.withValues(alpha: 0.8),
            ),
            const SizedBox(height: 20),
            Text(
              'Something went wrong',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView({required this.controller});

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
                onPressed: controller.clearFilters,
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
