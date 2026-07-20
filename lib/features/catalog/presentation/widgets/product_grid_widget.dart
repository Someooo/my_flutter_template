import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/catalog_controller.dart';
import 'product_card_widget.dart';

class ProductGridWidget extends StatelessWidget {
  const ProductGridWidget({super.key, required this.controller});

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
