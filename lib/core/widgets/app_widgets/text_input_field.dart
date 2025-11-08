import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../config/app_colors.dart';
import '../../extension/gap_extension.dart';
import '../../utils/app_text_style.dart';
import '../../utils/border.dart';
import 'button/button_constant.dart';

class AppTextFormField extends StatefulWidget {
  final String? label;
  final String? labelFloating;
  final String? initialValue;
  final TextStyle? labelTextStyle;
  final TextStyle? labelFloatingTextStyle;
  final String? errorText;
  final Color? fillColor;
  final String? hintText;
  final String? helperText;
  final List<String>? autoFillHint;
  final IconData? prefixIconAssetName;
  final Widget? prefixWidget;
  final String? prefixText;
  final String? prefixAddOnText;
  final bool prefixUseMastercard;
  final bool filled;
  final IconData? suffixIconAssetName;
  final Widget? suffixIconWidget;
  final Color? suffixIconColor;
  final IconData? suffixErrorIconAssetName;
  final VoidCallback? onTapSuffix;
  final bool enabled;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final TextStyle? hintStyle;
  final TextStyle? styleText;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final bool readOnly;
  final bool? showCursor;
  final String obscuringCharacter;
  final bool obscureText;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final double? contentVerticalPadding;
  final double? contentHorizontalPadding;
  final int? maxLength;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final bool clearOnFocus;
  final bool showClearIcon; // to use in profile read onlu feilf
  final bool? isMarked; // use in seletc date Add & edit promotions
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final bool? enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final InputBorder? customBorder;
  final Widget? Function(
    BuildContext, {
    required int currentLength,
    required bool isFocused,
    required int? maxLength,
  })? buildCounter;
  final AutovalidateMode? autoValidateMode;

  const AppTextFormField({
    this.isMarked,
    super.key,
    this.label,
    this.autoFillHint,
    this.errorText,
    this.hintText,
    this.initialValue,
    this.enabled = true,
    this.helperText,
    this.prefixIconAssetName,
    this.prefixWidget,
    this.prefixText,
    this.prefixAddOnText,
    this.prefixUseMastercard = false,
    this.filled = true,
    this.suffixIconAssetName,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.showCursor,
    this.maxLengthEnforcement,
    this.minLines,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.enableInteractiveSelection,
    this.selectionControls,
    this.buildCounter,
    this.maxLines = 1,
    this.obscuringCharacter = '*',
    this.expands = false,
    this.obscureText = false,
    this.autofocus = false,
    this.readOnly = false,
    this.suffixErrorIconAssetName = CupertinoIcons.info_circle,
    this.onTapSuffix,
    this.autoValidateMode,
    this.suffixIconColor,
    this.labelTextStyle,
    this.contentVerticalPadding,
    this.contentHorizontalPadding,
    this.labelFloating,
    this.labelFloatingTextStyle,
    this.textAlign,
    this.hintStyle,
    this.customBorder,
    this.styleText,
    this.focusNode,
    this.nextFocusNode,
    this.clearOnFocus = false,
    this.showClearIcon = true,
    this.suffixIconWidget,
    this.fillColor,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late final TextEditingController _internalController;
  TextEditingController get _effectiveController =>
      widget.controller ?? _internalController;

  @override
  void initState() {
    super.initState();
    _internalController =
        TextEditingController(text: widget.initialValue ?? "");
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry contentPadding;
    EdgeInsetsGeometry prefixAddOnTextContentPadding;

    contentPadding = EdgeInsets.symmetric(
      vertical: widget.contentVerticalPadding ?? 12.0,
      horizontal: widget.contentHorizontalPadding ?? 14.0,
    );
    prefixAddOnTextContentPadding = const EdgeInsets.symmetric(
      vertical: 14.0,
      horizontal: 14.0,
    );

    Widget? prefixWidgetBuilt;
    if (widget.prefixWidget != null) {
      prefixWidgetBuilt = widget.prefixWidget;
    } else if (widget.prefixText != null) {
      prefixWidgetBuilt = FittedBox(
        fit: BoxFit.scaleDown,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 8.0,
          ),
          child: Center(
            child: Text(
              widget.prefixText!,
            ),
          ),
        ),
      );
    } else if (widget.prefixIconAssetName != null) {
      prefixWidgetBuilt = FittedBox(
        fit: BoxFit.scaleDown,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 8.0,
          ),
          child: Icon(
            widget.prefixIconAssetName!,
            color: AppLightColors.primaryColor,
            size: 25.0,
          ),
        ),
      );
    } else if (widget.prefixAddOnText != null) {
      prefixWidgetBuilt = FittedBox(
        fit: BoxFit.scaleDown,
        child: Container(
          margin: const EdgeInsets.only(right: 12.0),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                color: widget.errorText == null
                    ? AppLightColors.primaryColor
                    : AppLightColors.primaryColor,
              ),
            ),
            // color: Colors.yellow,
          ),
          child: Padding(
            padding: prefixAddOnTextContentPadding,
            child: Center(
              child: Text(
                widget.prefixAddOnText!,
                // style: LibraryTextStyles.interMdRegularNeutral300,
              ),
            ),
          ),
        ),
      );
    }
    if (widget.clearOnFocus) {
      widget.focusNode?.addListener(() {
        if (widget.focusNode!.hasFocus) {
          widget.controller?.clear();
        }
      });
    }
    widget.focusNode?.addListener(() {
      if (!widget.focusNode!.hasFocus) {
        if (widget.onSaved != null) {
          widget.onSaved!(widget.controller?.text);
        }
      }
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: widget.labelTextStyle ?? AppTextStyle.bodyText),
          15.gap,
        ],
        ValueListenableBuilder<TextEditingValue>(
            valueListenable: _effectiveController,
            builder: (context, value, child) {
              return TextFormField(
                
                initialValue: widget.initialValue,
                style:  AppTextStyle.subTitle4,
                autofillHints: widget.autoFillHint,
                textAlign: widget.textAlign ?? TextAlign.start,
                enabled: widget.enabled,
                cursorColor: AppLightColors.primaryColor,
                focusNode: widget.focusNode,
                decoration: InputDecoration(
                  filled: widget.filled,
                  fillColor: widget.fillColor ?? Colors.white,
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  // hint: labelFloating != null
                  //     ? Text(
                  //         labelFloating!,
                  //         style: AppTextStyle.subTitle,
                  //       )
                  //     : null,
                  labelStyle: widget.labelFloatingTextStyle ??
                      AppTextStyle.subTitle4,
                  isDense: true,
                  contentPadding: contentPadding,
                  hintText: widget.hintText,
                  hintStyle: widget.hintStyle,
                  border: widget.customBorder ??
                      (widget.errorText == null
                          ? AppWidgetBorder.focusedBorder
                          : AppWidgetBorder.errorBorder),
                  enabledBorder: widget.customBorder ??
                      (widget.errorText == null
                          ? AppWidgetBorder.focusedBorder
                          : AppWidgetBorder.errorBorder),
                  disabledBorder:
                      widget.customBorder ?? AppWidgetBorder.disabledBorder,
                  focusedBorder: widget.customBorder ??
                      (widget.errorText == null
                          ? AppWidgetBorder.focusedBorder
                          : AppWidgetBorder.errorBorder),
                  prefixIcon: prefixWidgetBuilt,
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 0.0,
                    minHeight: 0.0,
                  ),

                  suffixIcon: (widget.showClearIcon &&
                          widget.controller != null &&
                          widget.controller!.text.isNotEmpty)
                      ? Padding(
                          padding: EdgeInsets.zero,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () {
                              widget.controller!.clear();
                              if (widget.onChanged != null) widget.onChanged!("");
                            },
                            icon: Icon(
                              Icons.highlight_remove,
                              color: AppLightColors.secondaryGreyColor,
                            ),
                          ),
                        )
                      : (widget.suffixIconWidget ??
                          (widget.suffixIconAssetName != null
                              ? IconButton(
                                  onPressed: widget.onTapSuffix,
                                  icon: Icon(
                                    widget.suffixIconAssetName,
                                    color: widget.suffixIconColor ??
                                        AppLightColors.primaryColor,
                                    size: 25.0,
                                  ),
                                )
                              : null)),
                ),
                controller: widget.controller,
                keyboardType: widget.keyboardType,
                textInputAction: widget.textInputAction,
                showCursor: widget.showCursor,
                maxLengthEnforcement: widget.maxLengthEnforcement,
                minLines: widget.minLines,
                maxLength: widget.maxLength,
                onChanged: widget.onChanged,
                onTap: widget.onTap,
                onEditingComplete: widget.onEditingComplete,
                onFieldSubmitted: (value) {
                  if (widget.onFieldSubmitted != null) {
                    widget.onFieldSubmitted!(value);
                  }
                  if (widget.nextFocusNode != null) {
                    FocusScope.of(context).requestFocus(widget.nextFocusNode);
                  } else {
                    FocusScope.of(context).unfocus();
                  }
                },
                onSaved: widget.onSaved,
                validator: widget.validator,
                enableInteractiveSelection: widget.enableInteractiveSelection,
                selectionControls: widget.selectionControls,
                buildCounter: widget.buildCounter,
                maxLines: widget.maxLines,
                obscuringCharacter: widget.obscuringCharacter,
                expands: widget.expands,
                obscureText: widget.obscureText,
                autofocus: widget.autofocus,
                readOnly: widget.readOnly,
              );
            }),
        if (widget.helperText != null && (widget.errorText == null || widget.enabled))
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              6.gap,
              Text(
                widget.helperText!,
              ),
            ],
          ),
        if (widget.errorText != null && widget.enabled)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              5.gap,
              Text(
                widget.errorText!,
              ),
            ],
          ),
        15.gap,
      ],
    );
  }
}
