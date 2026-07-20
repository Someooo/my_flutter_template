import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/catalog_controller.dart';
import '../widgets/catalog_app_bar_widget.dart';
import '../widgets/catalog_empty_widget.dart';
import '../widgets/catalog_error_widget.dart';
import '../widgets/catalog_loading_widget.dart';
import '../widgets/category_filter_widget.dart';
import '../widgets/product_grid_widget.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/summary_card_widget.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CatalogController>();

    return Scaffold(
      appBar: const CatalogAppBarWidget(),
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
                controller: controller.searchTextController,
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
      return const CatalogLoadingWidget();
    }

    if (controller.errorMessage != null) {
      return CatalogErrorWidget(
        message: controller.errorMessage!,
        onRetry: controller.loadProducts,
      );
    }

    if (controller.isEmpty) {
      return CatalogEmptyWidget(controller: controller);
    }

    return ProductGridWidget(controller: controller);
  }
}
