import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

import '../enums/text_style_enum.dart';
import 'custom_text_widget.dart';

class HeadingWithValue extends StatelessWidget {
  final String heading;
  final String value;
  final void Function()? onTap;
  final bool isExpanded;
  final int? maxLines;
  
  // New optional style parameters
  final TextStyle? headingStyle;
  final TextStyle? valueStyle;
  final TextThemeStyleEnum? headingTextThemeStyle;
  final TextThemeStyleEnum? valueTextThemeStyle;

  const HeadingWithValue({
    super.key, 
    required this.heading, 
    required this.value, 
    this.maxLines = 2, 
    this.onTap, 
    this.isExpanded = false,
    this.headingStyle,
    this.valueStyle,
    this.headingTextThemeStyle,
    this.valueTextThemeStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: heading,
          textThemeStyle: headingTextThemeStyle ?? TextThemeStyleEnum.displaySmall,
          textstyle: headingStyle,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onInverseSurface,
        ),
        CustomTextWidget(
          text: ' : ',
          textThemeStyle: headingTextThemeStyle ?? TextThemeStyleEnum.displaySmall,
          textstyle: headingStyle,
          color: Theme.of(context).colorScheme.onInverseSurface,
        ),
        isExpanded
            ? Expanded(
                child: buildTitles(context),
              )
            : buildTitles(context),
      ],
    );
  }

  GestureDetector buildTitles(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomTextWidget(
        text: value,
        textThemeStyle: valueTextThemeStyle ?? TextThemeStyleEnum.displaySmall,
        textstyle: valueStyle,
        fontWeight: FontWeight.w500,
        maxLines: maxLines,
        color: onTap != null ? SharedColors.seaBlue : Theme.of(context).colorScheme.onInverseSurface,
        decoration: onTap != null ? TextDecoration.underline : TextDecoration.none,
        decorationStyle: TextDecorationStyle.solid,
        decorationThickness: 1,
      ),
    );
  }
}
