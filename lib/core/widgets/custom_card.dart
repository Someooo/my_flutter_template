import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app_colors.dart';

import '../utils/shared.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final bool allowPadding;
  final bool allowBorder;
  final double? elevation;
  final double? radius;

  const CustomCard({
    super.key,
    required this.child,
    this.color,
    this.elevation,
    this.radius,
    this.allowPadding = true,
    this.allowBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation ?? 8,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? UIConstants.radius20),
          side: allowBorder ? BorderSide(color: SharedColors.darkBlue) : BorderSide.none),
      // borderRadius: BorderRadius.circular(12.r),
      color: color,
      // elevation: 4,
      shadowColor: Get.theme.primaryColor.withAlpha(50),
      child: Padding(
        padding: allowPadding ? UIConstants.allPadding : EdgeInsets.zero,
        child: child,
      ),
    );
  }
}
