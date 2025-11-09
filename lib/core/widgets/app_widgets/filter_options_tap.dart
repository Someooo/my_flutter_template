

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../../utils/responsive.dart';
import '../custom_text_widget.dart';
import 'button/neumorphic_plus.dart';

/// Configuration class for filter options
class FilterOption {
  final String value;
  final String translationKey;
  final Color? selectedColor;
  final Color? unselectedColor;
  final FontWeight? selectedFontWeight;
  final FontWeight? unselectedFontWeight;

  const FilterOption({
    required this.value,
    required this.translationKey,
    this.selectedColor,
    this.unselectedColor,
    this.selectedFontWeight,
    this.unselectedFontWeight,
  });
}

/// Dynamic filter widget that can be reused across different screens
class DynamicFilterWidget extends StatelessWidget {
  final List<FilterOption> filterOptions;
  final String? currentFilter;
  final Function(String) onFilterSelected;
  final Color defaultSelectedColor;
  final Color defaultUnselectedColor;
  final FontWeight defaultSelectedFontWeight;
  final FontWeight defaultUnselectedFontWeight;
  final double spacingBetweenOptions;
  final double buttonHeight;
  final Color buttonColor;
  final double horizontalPadding;
  final double bottomSpacing;

  const DynamicFilterWidget({
    super.key,
    required this.filterOptions,
    required this.currentFilter,
    required this.onFilterSelected,
    this.defaultSelectedColor = AppLightColors.primaryColor,
    this.defaultUnselectedColor = Colors.black,
    this.defaultSelectedFontWeight = FontWeight.bold,
    this.defaultUnselectedFontWeight = FontWeight.normal,
    this.spacingBetweenOptions = 70.0,
    this.buttonHeight = 50.0,
    this.buttonColor = Colors.white,
    this.horizontalPadding = 25.0,
    this.bottomSpacing = 25.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            // horizontalPadding.gap,
            Expanded(
              child: AppOvalButton(
                height: buttonHeight.h,
                color: buttonColor,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildFilterOptions(),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: bottomSpacing.h),
      ],
    );
  }

  List<Widget> _buildFilterOptions() {
    final List<Widget> options = [];

    for (int i = 0; i < filterOptions.length; i++) {
      final option = filterOptions[i];
      final isSelected = currentFilter == option.value;

      options.add(
        Expanded(
          child: GestureDetector(
            onTap: () => onFilterSelected(option.value),
            child: Center(
              child: CustomTextWidget(
                text: option.translationKey.tr,
                color: isSelected
                    ? (option.selectedColor ?? defaultSelectedColor)
                    : (option.unselectedColor ?? defaultUnselectedColor),
                fontSize:  Responsive.isTablet? 6.sp :15.sp,
                fontWeight: isSelected
                    ? (option.selectedFontWeight ?? defaultSelectedFontWeight)
                    : (option.unselectedFontWeight ?? defaultUnselectedFontWeight),
              ),
            ),
          ),
        ),
      );
    }

    return options;
  }
}
