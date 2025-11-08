import 'package:flutter/material.dart';
import 'package:my_template/config/app_colors.dart';

import '../../../../config/config.dart';
import '../../../extension/gap_extension.dart';
import 'button_constant.dart';

class AppButton extends StatelessWidget {
  final double height;
  final Color? color;
  final Gradient? gradient;

  final BorderRadius? borderRadius;
  final Widget Function(BuildContext context, bool isFocused, bool isHovered)
      builder;
  final void Function()? onPressed;

  final EdgeInsetsGeometry? contentPadding;

  final bool isDestructive;
  final bool isLoading;

  const AppButton({
    
    super.key,
    required this.height,
    required this.builder,
    this.onPressed,
    this.contentPadding,
    required this.isDestructive,
    this.color,
    this.gradient,
    this.borderRadius,
    this.isLoading = false,
  });

  factory AppButton.text({
    double? width,
    required String text,
    double height = AppButtonHeights.md,
    required void Function()? onPressed,
    Color? color,
    Gradient? gradient,
    Color? fontColor,
    TextStyle? textStyle,
    bool isDestructive = false,
    BorderRadius? borderRadius,
    Key? key,
    bool isLoading = false,
  }) {
    return AppButton(
      key: key,
      borderRadius: borderRadius,
      color: color,
      gradient: gradient,
      height: height,
      onPressed: isLoading ? null : onPressed,
      isDestructive: isDestructive,
      isLoading: isLoading,
      builder: (_, __, ___) => Text(
        text,
        textAlign: TextAlign.center,
        style: textStyle ??
            TextStyle(
              color: fontColor ?? Colors.white,
              fontSize: AppButtonTextFontSize.fromButtonHeights(height),
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }

  factory AppButton.icon({
    required String text,
    IconData? leadingIconAssetName,
    IconData? trailingIconAssetName,
    double height = AppButtonHeights.lg,
    required void Function()? onPressed,
    Color? color,
    Gradient? gradient,
    bool isDestructive = false,
    Key? key,
    bool isLoading = false,
  }) {
    return AppButton(
      key: key,
      color: color,
      gradient: gradient,
      height: height,
      onPressed: isLoading ? null : onPressed,
      isDestructive: isDestructive,
      isLoading: isLoading,
      builder: (_, __, ___) => Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          leadingIconAssetName != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      leadingIconAssetName,
                      color: Colors.white,
                      size: AppButtonIconSize.fromButtonHeights(height),
                    ),
                    8.gap,
                  ],
                )
              : Container(),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: AppButtonTextFontSize.fromButtonHeights(height),
              fontWeight: FontWeight.w400,
            ),
          ),
          if (trailingIconAssetName != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                8.gap,
                Icon(
                  trailingIconAssetName,
                  color: Colors.white,
                  size: AppButtonIconSize.fromButtonHeights(height),
                ),
              ],
            )
        ],
      ),
    );
  }

  /// Creates [AppButton] with only an icon as content.
  factory AppButton.iconOnly({
    required IconData iconAssetName,
    double height = AppButtonHeights.md,
    void Function()? onPressed,
    bool isDestructive = false,
    Color? color,
    Gradient? gradient,
    Key? key,
    bool isLoading = false,
  }) {
    return AppButton(
      key: key,
      height: height,
      onPressed: isLoading ? null : onPressed,
      isLoading: isLoading,
      color: color,
      gradient: gradient,
      isDestructive: isDestructive,
      contentPadding: AppButtonIconOnlyPadding.fromButtonHeights(height),
      builder: (_, __, ___) => Icon(
        iconAssetName,
        color: Colors.white,
        size: AppButtonIconSize.fromButtonHeights(height),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    late Color primaryColor;
    late Color disabledColor;
    late Color hoverColor;
    late Color focusColor;
    if (!isDestructive) {
      primaryColor = color ?? AppLightColors.primaryColor;
      disabledColor = AppLightColors.primaryColor;
      hoverColor = AppLightColors.redColor;
      focusColor = AppLightColors.primaryColor;
    } else {
      primaryColor = color ?? AppLightColors.primaryColor;
      disabledColor = AppLightColors.redColor;
      hoverColor = AppLightColors.primaryColor;
      focusColor = AppLightColors.primaryColor;
    }
    
    // If gradient is provided, use a different structure
    if (gradient != null) {
      return Container(
        decoration: BoxDecoration(
          gradient: onPressed != null || isLoading ? gradient : null,
          color: onPressed == null && !isLoading ? disabledColor : null,
          borderRadius: borderRadius ?? BorderRadius.circular(100),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: borderRadius ?? BorderRadius.circular(100),
          child: InkWell(
            borderRadius: borderRadius ?? BorderRadius.circular(100),
            hoverColor: hoverColor.withOpacity(0.1),
            focusColor: focusColor.withOpacity(0.1),
            onTap: isLoading ? null : onPressed,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius ?? BorderRadius.circular(100),
              ),
              child: Padding(
                padding:
                    contentPadding ?? AppButtonPadding.fromButtonHeights(height),
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    transitionBuilder: (child, animation) =>
                        FadeTransition(opacity: animation, child: child),
                    child: isLoading
                        ? SizedBox(
                            key: const ValueKey('loader'),
                            width: height * 0.5,
                            height: height * 0.5,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : builder(context, true, true)
                            .keyed(const ValueKey('text')),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    
    // Default solid color behavior (unchanged for backward compatibility)
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(100),
      ),
      child: Material(
        color: onPressed != null || isLoading ? primaryColor : disabledColor,
        borderRadius: borderRadius ?? BorderRadius.circular(100),
        child: InkWell(
          borderRadius: borderRadius ?? BorderRadius.circular(100),
          hoverColor: hoverColor,
          focusColor: focusColor,
          onTap: isLoading ? null : onPressed,
          child: Container(
            // height: height,
            decoration: BoxDecoration(
              borderRadius: borderRadius ?? BorderRadius.circular(100),
            ),
            child: Padding(
              padding:
                  contentPadding ?? AppButtonPadding.fromButtonHeights(height),
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
                  child: isLoading
                      ? SizedBox(
                          key: const ValueKey('loader'),
                          width: height * 0.5,
                          height: height * 0.5,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : builder(context, true, true)
                          .keyed(const ValueKey('text')),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension _Keyed on Widget {
  Widget keyed(Key key) => KeyedSubtree(key: key, child: this);
}
