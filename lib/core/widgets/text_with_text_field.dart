import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_form_field.dart';
import 'custom_text_widget.dart';

class TextWithTextField extends StatefulWidget {
  const TextWithTextField({
    super.key,
    this.suffixIcon,
    this.onTap,
    required this.text,
    this.controller, // Made optional
    this.value, // Added value parameter
    this.textStyle,
    this.errorString,
    this.hintText,
    this.isPass,
    this.keyType,
    this.maxLength,
    this.maxLines = 1,
    this.radius,
    this.contentPadding,
    this.verticalPadding,
    this.verticalSpacing, // Added new parameter for controlling spacing
    this.validator,
    this.focusNode,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onChanged,
    this.filled,
    this.hideLabel = false,
    this.hasBorderSide = true,
    this.enabled,
    this.width,
    this.suffix,
    this.numbersOnly,
    this.prefix, 
    this.minLines,
  });
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final int? minLines;
  final String text;
  final TextStyle? textStyle;
  final TextEditingController? controller; // Made optional
  final String? value; // Added value parameter
  final String? errorString;
  final String? hintText;
  final bool? isPass;
  final bool hideLabel;
  final TextInputType? keyType;
  final int? maxLength;
  final int? maxLines;
  final double? radius;
  final double? contentPadding;
  final double? verticalPadding;
  final double? verticalSpacing; // Added new parameter
  final FormFieldValidator? validator;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final dynamic Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final bool? filled;
  final bool? hasBorderSide;
  final bool? enabled;
  final double? width;
  final Widget? suffix;
  final Widget? prefix;
  final bool? numbersOnly;

  @override
  State<TextWithTextField> createState() => _TextWithTextFieldState();
}

class _TextWithTextFieldState extends State<TextWithTextField> {
  late TextEditingController _internalController;

  @override
  void initState() {
    super.initState();
    // Use provided controller or create internal one
    _internalController = widget.controller ?? TextEditingController(text: widget.value ?? '');
  }

  @override
  void didUpdateWidget(TextWithTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update internal controller if value changes
    if (widget.value != null && widget.controller == null) {
      _internalController.text = widget.value!;
    }
  }

  @override
  void dispose() {
    // Only dispose if we created the controller internally
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.verticalSpacing ?? 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!widget.hideLabel)
            widget.errorString != null
                ? Row(
                    children: [
                      CustomTextWidget(
                        text: widget.text,
                        fontWeight: FontWeight.w500,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: CustomTextWidget(
                          text: widget.errorString!,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  )
                : CustomTextWidget(
                    text: widget.text,
                    fontWeight: FontWeight.w500,
                  ),
          SizedBox(height: widget.verticalSpacing != null ? (widget.verticalSpacing! / 2) : 10.h),
          SizedBox(
            width: widget.width ?? MediaQuery.of(context).size.width * 0.4,
            child: CustomFormField(
              hintText: widget.hintText,
              controller: _internalController,
              isPass: widget.isPass,
              maxLines: widget.maxLines,
              keyType: widget.keyType,
              maxLength: widget.maxLength,
              radius: widget.radius,
              numbersOnly: widget.numbersOnly,
              contentPadding: widget.contentPadding ?? 10,
              verticalPadding: widget.verticalPadding,
              validator: widget.validator,
              focusNode: widget.focusNode,
              onEditingComplete: widget.onEditingComplete,
              onFieldSubmitted: widget.onFieldSubmitted,
              onChanged: (widget.onChanged != null)
                  ? widget.onChanged
                  : (widget.errorString != null)
                      ? (p0) {
                          setState(() {});
                        }
                      : null,
              onTap: widget.onTap,
              filled: widget.filled,
              
              filledColor: Colors.white,
              hasBorderSide: widget.hasBorderSide,
              enabled: widget.enabled,
              suffix: widget.suffixIcon ?? widget.suffix,
              prefix: widget.prefix,
            ),
          ),
        ],
      ),
    );
  }
}
