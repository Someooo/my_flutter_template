import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app_colors.dart';
import '../enums/text_style_enum.dart';

import 'custom_text_widget.dart';

// class CustomButton extends StatelessWidget {
//   final VoidCallback onPressed;
//   final Color? backgroundColor;
//   final Color? borderColor;
//   final double? fontSize;
//   final Widget? child;
//   final double? height;
//   final double? width;
//   final double? elevation;
//   final double borderRadius;
//   final Widget? icon;
//   final String? label;
//   final bool? darkText;
//   final String? text;
//
//   const CustomButton({
//     super.key,
//     required this.onPressed,
//     this.backgroundColor,
//     this.borderColor,
//     this.fontSize,
//     this.child,
//     this.height = 50,
//     this.width,
//     this.elevation,
//     this.borderRadius = 8.0, // Default border radius
//     this.icon,
//     this.label,
//     this.darkText,
//     this.text,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: height,
//       width: width,
//       child: icon != null && label != null
//           ? ElevatedButton.icon(
//               onPressed: onPressed,
//               style: ElevatedButton.styleFrom(
//                 elevation: elevation ?? 0,
//                 backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
//                 side: borderColor != null
//                     ? BorderSide(
//                         color: borderColor ?? Colors.white,
//                         width: 1,
//                       )
//                     : null,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(borderRadius),
//                 ),
//               ),
//               label: CustomTextWidget(
//                 text: label ?? "",
//               ),
//               icon: icon!,
//             )
//           : ElevatedButton(
//               onPressed: onPressed,
//               style: ElevatedButton.styleFrom(
//                 elevation: elevation ?? 0,
//                 backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
//                 side: borderColor != null
//                     ? BorderSide(
//                         color: borderColor ?? Colors.white,
//                         width: 1,
//                       )
//                     : null,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(borderRadius),
//                 ),
//               ),
//               child: text != null
//                   ? CustomTextWidget(
//                       text: text ?? "",
//                     )
//                   : child,
//             ),
//     );
//   }
// }

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? fontSize;
  final Widget? child;
  final double? height;
  final double? width;
  final double? elevation;
  final double borderRadius;
  final Widget? icon;
  final String? label;
  final bool? darkText;
  final String? text;
  final bool useGradient; // New bool to enable gradient
  final TextStyle? textStyle; // Custom text style

  const CustomButton({
    super.key,
    required this.onPressed,
    this.backgroundColor,
    this.borderColor,
    this.fontSize,
    this.child,
    this.height = 50,
    this.width,
    this.elevation,
    this.borderRadius = 15,
    this.icon,
    this.label,
    this.darkText,
    this.text,
    this.useGradient = true, // Default is false
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: elevation ?? 0,
        backgroundColor: useGradient ? Colors.transparent : backgroundColor ?? Theme.of(context).primaryColor,
        side: borderColor != null
            ? BorderSide(
                color: borderColor!,
                width: 1,
              )
            : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: text != null
          ? textStyle != null
              ? Text(
                  text ?? "",
                  style: textStyle,
                )
              : CustomTextWidget(
                  text: text ?? "",
                  color: Get.theme.colorScheme.onSurface,
                )
          : child,
    );

    return SizedBox(
      height: height,
      width: width,
      child: icon != null && label != null
          ? ElevatedButton.icon(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                elevation: elevation ?? 0,
                backgroundColor:
                    useGradient ? Colors.transparent : backgroundColor ?? Theme.of(context).primaryColor,
                side: borderColor != null
                    ? BorderSide(
                        color: borderColor!,
                        width: 1,
                      )
                    : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              label: textStyle != null
                  ? Text(
                      label ?? "",
                      style: textStyle,
                    )
                  : CustomTextWidget(
                      text: label ?? "",
                    ),
              icon: icon!,
            )
          : useGradient
              ? Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        SharedColors.primaryColor,
                        SharedColors.secondaryColor,
                      ],
                      // stops: const [0.0, 0.5],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      // colors: [Colors.blue, Colors.purple],
                      // begin: Alignment.topLeft,
                      // end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: button,
                )
              : button,
    );
  }
}

class RoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Widget child;
  final double? height;
  final double? width;

  final double borderRadius;

  const RoundedButton({
    super.key,
    required this.onPressed,
    this.backgroundColor,
    required this.child,
    this.height,
    this.width,
    this.borderRadius = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor ?? SharedColors.darkBlue,
            shape: BoxShape.circle,
            border: Border.all(color: Theme.of(context).colorScheme.onSurface),
          ),
          child: child,
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final TextThemeStyleEnum? textThemeStyle;
  final Color? textColor;
  final bool underline;

  const CustomTextButton({
    super.key,
    this.onTap,
    this.textThemeStyle,
    this.textColor,
    this.underline = false,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: onTap,
        splashColor: Get.theme.primaryColor.withAlpha(50),
        // highlightColor: Colors.green,
        borderRadius: BorderRadius.circular(5),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          child: CustomTextWidget(
            text: text,
            maxLines: 1,
            textThemeStyle: textThemeStyle ?? TextThemeStyleEnum.displaySmall,
            color: textColor ?? AppLightColors.primaryColor,
            decoration: underline ? TextDecoration.underline : null,
          ),
        ),
      ),
    );
  }
}

