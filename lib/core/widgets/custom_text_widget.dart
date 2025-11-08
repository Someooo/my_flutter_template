import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../enums/text_style_enum.dart';

import '../../config/app_colors.dart';

// Enum for TextTheme styles

class CustomTextWidget extends StatelessWidget {
  final String text;
  final TextStyle? textstyle;
  final VoidCallback? onTap;
  final TextAlign? textAlign;
  final int? maxLines;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final double? letterSpacing;
  final String? fontFamily;
  final TextOverflow? overflow;
  final double? height;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final double? decorationThickness;
  final TextDecorationStyle? decorationStyle;
  final TextDirection? textDirection;
  final String? toolTipText;
  final TextThemeStyleEnum? textThemeStyle;
  final bool isLocalize;

  const CustomTextWidget({
    super.key,
    this.textstyle,
    this.onTap,
    required this.text,
    this.textAlign,
    this.maxLines,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.letterSpacing,
    this.fontFamily,
    this.overflow,
    this.height,
    this.decoration,
    this.decorationColor,
    this.decorationThickness,
    this.decorationStyle,
    this.textDirection,
    this.toolTipText,
    this.textThemeStyle,
    this.isLocalize = true,
  });

  TextStyle _buildTextStyle(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    // Select the base style based on the enum, but check if fontSize is provided first
    TextStyle baseStyle;
    if (fontSize != null) {
      // If fontSize is provided, ignore the TextThemeStyleEnum and use custom fontSize
      baseStyle = textTheme.displayMedium ?? const TextStyle(); // Use a default style when overriding
    } else {
      // Otherwise, select the base style according to the enum
      switch (textThemeStyle) {
        //
        case TextThemeStyleEnum.bodyExtraSmall:
          baseStyle = textTheme.titleSmall ?? const TextStyle();
          break;
        //
        case TextThemeStyleEnum.titleMedium:
          baseStyle = textTheme.titleMedium ?? const TextStyle();
          break;
        //
        case TextThemeStyleEnum.titleLarge:
          baseStyle = textTheme.titleLarge ?? const TextStyle();
          break;
        //
        case TextThemeStyleEnum.bodySmall:
          baseStyle = textTheme.bodySmall ?? const TextStyle();
          break;
        //
        case TextThemeStyleEnum.bodyMedium:
          baseStyle = textTheme.bodyMedium ?? const TextStyle();
          break;
        //
        case TextThemeStyleEnum.bodyLarge:
          baseStyle = textTheme.bodyLarge ?? const TextStyle();
          break;
        //
        case TextThemeStyleEnum.displaySmall:
          baseStyle = textTheme.displaySmall ?? const TextStyle();
          break;
        case TextThemeStyleEnum.displayLarge:
          baseStyle = textTheme.displayLarge ?? const TextStyle();
          break;
        case TextThemeStyleEnum.headlineSmall:
          baseStyle = textTheme.headlineSmall ?? const TextStyle();
          break;
        case TextThemeStyleEnum.headlineMedium:
          baseStyle = textTheme.headlineMedium ?? const TextStyle();
          break;
        case TextThemeStyleEnum.headlineLarge:
          baseStyle = textTheme.headlineLarge ?? const TextStyle();
          break;
        // case TextThemeStyleEnum.displayMedium:
        default:
          baseStyle = textTheme.displayMedium ?? const TextStyle();
          break;
      }
    }

    // Return the customized text style with the provided properties, including fontSize if given
    return baseStyle.copyWith(
      fontSize: fontSize?.sp ?? baseStyle.fontSize?.sp,
      fontWeight: fontWeight ?? baseStyle.fontWeight,
      color: color ?? baseStyle.color,
      letterSpacing: letterSpacing ?? 0,
      height: height?.sp ?? 0.0.sp,
      decoration: decoration ?? TextDecoration.none,
      decorationColor: decorationColor ?? color,
      decorationThickness: decorationThickness ?? 1.5,
      decorationStyle: decorationStyle ?? TextDecorationStyle.solid,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: toolTipText ?? '',
      textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
            color: AppLightColors.appBackgroundColor,
          ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        isLocalize ? text.tr: text,
        textAlign: textAlign ?? TextAlign.start,
        maxLines: maxLines,
        overflow: overflow ?? TextOverflow.ellipsis,

        style:textstyle?? _buildTextStyle(context),
      ),
    );
  }
}
