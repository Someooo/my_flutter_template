import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../config/app_colors.dart';
import '../utils/responsive.dart';

class CustomFormField extends StatelessWidget {
  final String? hintText;
  final TextEditingController controller;
  final bool? isPass;
  final TextInputType? keyType;
  final int? maxLength;
  final double? radius;
  final double? contentPadding;
  final double? verticalPadding;
  final FormFieldValidator? validator;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final bool? filled;
  final Color? filledColor;
  final bool? hasBorderSide;
  final bool? enabled;
  final Widget? suffix;
  final Widget? prefix;
  final bool? numbersOnly;
  final TextInputAction? textInputAction;
  final Color? inputColor;
  final TextStyle? textStyle;
  final int? maxLines;
  final VoidCallback? onTap;
  final TextStyle? hintStyle;

  const CustomFormField({
    super.key,
    this.hintText,
    required this.controller,
    this.isPass,
    this.keyType,
    this.maxLength,
    this.radius,
    this.contentPadding,
    this.verticalPadding,
    this.validator,
    this.focusNode,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.filled,
    this.filledColor,
    this.hasBorderSide = true,
    this.enabled,
    this.onChanged,
    this.suffix,
    this.prefix,
    this.numbersOnly,
    this.textInputAction,
    this.inputColor,
    this.textStyle,
    this.maxLines = 1,
    this.onTap,
    this.hintStyle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: TextFormField(
        onTap: onTap,
        style: textStyle ?? TextStyle(color: inputColor ?? Colors.black87, fontSize: 15.sp),
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        inputFormatters: [
          if (numbersOnly == true) FilteringTextInputFormatter.digitsOnly
        ],
        enabled: enabled ?? true,
        focusNode: focusNode,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        validator: validator,
        maxLength: maxLength,
        keyboardType: keyType,
        obscureText: isPass ?? false,
        controller: controller,
        textInputAction: textInputAction,
        maxLines: maxLines,
        decoration: InputDecoration(
          fillColor: filled != null && filledColor != null ? filledColor : null,
          suffixIcon: suffix,
          prefixIcon: prefix,
          filled: filled ?? false,
          errorMaxLines: 1,
          errorBorder: OutlineInputBorder(
            borderSide: hasBorderSide == true
                ? BorderSide(color: SharedColors.redColor)
                : BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: hasBorderSide == true
                ? const BorderSide(color: Color(0XFFCBD5E1))
                : BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                hasBorderSide == true ? const BorderSide() : BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide:
                hasBorderSide == true ? const BorderSide() : BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: hasBorderSide == true
                ? const BorderSide(color: Color(0XFFCBD5E1))
                : BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: contentPadding ?? 0,
            vertical: verticalPadding == null
                ? Responsive.isTablet == true
                    ? 20.h
                    : 0
                : 0,
          ),
          hintStyle: hintStyle ?? const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderSide: hasBorderSide == true
                ? const BorderSide(color: Color(0XFFCBD5E1))
                : BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
          ),
          hintText: hintText != null ? hintText!.tr : hintText,
        ),
      ),
    );
  }
}
