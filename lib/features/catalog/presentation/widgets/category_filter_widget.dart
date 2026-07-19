import 'package:flutter/material.dart';

class CategoryFilterWidget extends StatelessWidget {
  final List<String> categories;

  final String selectedCategory;

  final ValueChanged<String>? onCategorySelected;

  const CategoryFilterWidget({
    super.key,
    this.categories = const [],
    this.selectedCategory = '',
    this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == 'All'
              ? selectedCategory.isEmpty
              : category == selectedCategory;

          return FilterChip(
            label: Text(
              category,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? Colors.white
                    : colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            selected: isSelected,
            onSelected: onCategorySelected == null
                ? null
                : (_) => onCategorySelected!(
                      category == 'All' ? '' : category,
                    ),
            selectedColor: colorScheme.primary,
            backgroundColor: colorScheme.surface,
            checkmarkColor: Colors.white,
            showCheckmark: false,
            side: BorderSide(
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.outline.withValues(alpha: 0.3),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          );
        },
      ),
    );
  }
}
