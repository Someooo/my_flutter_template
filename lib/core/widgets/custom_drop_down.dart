// import 'package:get/get.dart';
// import '../enums/text_style_enum.dart';
// import '../utils/responsive.dart';
// import 'custom_text_widget.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CustomDropdownButton2 extends StatelessWidget {
//   final String hint;
//   final String? value;
//   final List<String> dropdownItems;
//   final ValueChanged<String?>? onChanged;
//   final DropdownButtonBuilder? selectedItemBuilder;
//   final Alignment? hintAlignment;
//   final Alignment? valueAlignment;
//   final double? buttonHeight, buttonWidth;
//   final EdgeInsetsGeometry? buttonPadding;
//   final BoxDecoration? buttonDecoration;
//   final int? buttonElevation;
//   final Widget? icon;
//   final double? iconSize;
//   final Color? iconEnabledColor;
//   final Color? iconDisabledColor;
//   final double? itemHeight;
//   final EdgeInsetsGeometry? itemPadding;
//   final double? dropdownHeight, dropdownWidth;
//   final EdgeInsetsGeometry? dropdownPadding;
//   final BoxDecoration? dropdownDecoration;
//   final int? dropdownElevation;
//   final Radius? scrollbarRadius;
//   final double? scrollbarThickness;
//   final bool? scrollbarAlwaysShow;
//   // final Offset? offset;

//   const CustomDropdownButton2({
//     required this.hint,
//     required this.value,
//     required this.dropdownItems,
//     required this.onChanged,
//     this.selectedItemBuilder,
//     this.hintAlignment,
//     this.valueAlignment,
//     this.buttonHeight,
//     this.buttonWidth,
//     this.buttonPadding,
//     this.buttonDecoration,
//     this.buttonElevation,
//     this.icon,
//     this.iconSize,
//     this.iconEnabledColor,
//     this.iconDisabledColor,
//     this.itemHeight,
//     this.itemPadding,
//     this.dropdownHeight,
//     this.dropdownWidth,
//     this.dropdownPadding,
//     this.dropdownDecoration,
//     this.dropdownElevation,
//     this.scrollbarRadius,
//     this.scrollbarThickness,
//     this.scrollbarAlwaysShow,
//     // this.offset,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2(
//         //To avoid long text overflowing.
//         isExpanded: true,
//         style: Theme.of(context).textTheme.displaySmall!.copyWith(
//               color: Theme.of(context).colorScheme.surface,
//             ),
//         barrierColor: Theme.of(context).colorScheme.surface.withValues(alpha:  0.8),
//         hint: Container(
//             alignment: hintAlignment, child: CustomTextWidget(text: hint   , fontSize: Responsive.isTablet ? 3.sp : 15.sp,)),
//         value: value,
//         items: dropdownItems
//             .map(
//               (item) => DropdownMenuItem<String>(
//                 value: item,
//                 child: Container(
//                     width: double.infinity,
//                     alignment:
//                         valueAlignment ?? AlignmentDirectional.centerStart,
//                     child: CustomTextWidget(
//                                     fontSize: Responsive.isTablet ? 3.sp : 15.sp,

//                       text: item,
//                       textThemeStyle: TextThemeStyleEnum.displaySmall,
//                       color: Theme.of(context).colorScheme.primaryContainer,
//                     )),
//               ),
//             )
//             .toList(),
//         onChanged: onChanged,
//         selectedItemBuilder: selectedItemBuilder,

//         iconStyleData: IconStyleData(
//           iconSize: iconSize ?? 25.0.sp,
//           iconEnabledColor: iconEnabledColor,
//           iconDisabledColor: iconDisabledColor,
//         ),

//         buttonStyleData: ButtonStyleData(
//           height: buttonHeight ?? 40.h,
//           width: buttonWidth ?? 317.w,
//           padding: buttonPadding ??
//               EdgeInsets.symmetric(
//                 horizontal: 11.0.w,
//                 vertical: 6.0.h,
//               ),
//           decoration: buttonDecoration ??
//               BoxDecoration(
//                 borderRadius: BorderRadius.circular(10.0.r),
//                 border: Border.all(
//                   color: Theme.of(context).colorScheme.primaryContainer,
//                 ),
//               ),
//           elevation: buttonElevation,
//         ),

//         menuItemStyleData: MenuItemStyleData(
//           height: itemHeight ?? 45.h,
//           padding: itemPadding ?? EdgeInsets.symmetric(horizontal: 8.0.w),
//         ),

//         //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
//         dropdownStyleData: DropdownStyleData(
//           maxHeight: dropdownHeight ?? 190.0.h,
//           width: dropdownWidth ?? 320.w,
//           padding: dropdownPadding ??
//               EdgeInsets.symmetric(
//                 horizontal: 10.0.w,
//                 vertical: 10.0.h,
//               ),
//           decoration: dropdownDecoration ??
//               BoxDecoration(
//                 borderRadius: BorderRadius.circular(10.0.r),
//               ),
//           elevation: dropdownElevation ?? 8,
//           scrollbarTheme: ScrollbarThemeData(
//             thumbColor: WidgetStateProperty.all(
//                 Theme.of(context).colorScheme.primaryContainer),
//             radius: scrollbarRadius ?? Radius.circular(10.0.r),
//             thickness: WidgetStateProperty.all(scrollbarThickness ?? 8.0.w),
//             trackVisibility: WidgetStateProperty.all(
//               scrollbarAlwaysShow ?? true,
//             ),
//           ),
//           isOverButton: false, //Default is false to show menu below button
//         ),
//       ),
//     );
//   }
// }


// class CustomGenericDropdownButton2<T> extends StatelessWidget {
//   final String hint;
//   final TextStyle? hintTextStyle;
//   final TextStyle? valueTextStyle;
//   final TextStyle? itemTextBuilderStyle;
//   final T? value;
//   final List<T> dropdownItems;
//   final ValueChanged<T?>? onChanged;
//   final DropdownButtonBuilder? selectedItemBuilder;
//   final Alignment? hintAlignment;
//   final Alignment? valueAlignment;
//   final double? buttonHeight, buttonWidth;
//   final EdgeInsetsGeometry? buttonPadding;
//   final BoxDecoration? buttonDecoration;
//   final int? buttonElevation;
//   final Widget? icon;
//   final double? iconSize;
//   final Color? iconEnabledColor;
//   final Color? iconDisabledColor;
//   final double? itemHeight;
//   final EdgeInsetsGeometry? itemPadding;
//   final double? dropdownHeight, dropdownWidth;
//   final EdgeInsetsGeometry? dropdownPadding;
//   final BoxDecoration? dropdownDecoration;
//   final int? dropdownElevation;
//   final Radius? scrollbarRadius;
//   final double? scrollbarThickness;
//   final bool? scrollbarAlwaysShow;
//   final String Function(T) itemTextBuilder;

//   // final Offset? offset;

//   const CustomGenericDropdownButton2({
//     required this.hint,
//     this.hintTextStyle,
//     this.valueTextStyle,
//     this.itemTextBuilderStyle,
//     required this.value,
//     required this.dropdownItems,
//     required this.onChanged,
//     required this.itemTextBuilder,
//     this.selectedItemBuilder,
//     this.hintAlignment,
//     this.valueAlignment,
//     this.buttonHeight,
//     this.buttonWidth,
//     this.buttonPadding,
//     this.buttonDecoration,
//     this.buttonElevation,
//     this.icon,
//     this.iconSize,
//     this.iconEnabledColor,
//     this.iconDisabledColor,
//     this.itemHeight,
//     this.itemPadding,
//     this.dropdownHeight,
//     this.dropdownWidth,
//     this.dropdownPadding,
//     this.dropdownDecoration,
//     this.dropdownElevation,
//     this.scrollbarRadius,
//     this.scrollbarThickness,
//     this.scrollbarAlwaysShow,
//     // this.offset,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<T>(
//         //To avoid long text overflowing.
//         isExpanded: true,
//         style: valueTextStyle ?? Theme.of(context).textTheme.titleSmall!.copyWith(
//           color: Get.theme.colorScheme.inverseSurface,
//           fontSize: Responsive.isTablet ? 3.sp : 15.sp,
//         ),
//         barrierColor: Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
//         hint: Container(
//             alignment: hintAlignment,
//             child: hintTextStyle != null
//                 ? Text(hint.tr, style: hintTextStyle)
//                 : CustomTextWidget(
//                     text: hint,
//                     textThemeStyle: TextThemeStyleEnum.displaySmall,
//                     color: Get.theme.colorScheme.onTertiary,
//                     fontSize: Responsive.isTablet ? 3.sp : 15.sp,
//                   )),
//         value: value,
//         items: dropdownItems
//             .asMap()
//             .entries
//             .map(
//               (entry) => DropdownMenuItem<T>(
//             value: entry.value,
//             child: Container(
//               height: 90.h,
//               width: double.infinity,
//               alignment: Alignment.center,
//               decoration: entry.key < dropdownItems.length - 1
//                   ? BoxDecoration(
//                       border: Border(
//                         bottom: BorderSide(
//                           color: const Color(0xFFE6E6E6),
//                           width: 1,
//                         ),
//                       ),
//                     )
//                   : null,
//               child: itemTextBuilderStyle != null
//                   ? Text(
//                       itemTextBuilder(entry.value),
//                       style: itemTextBuilderStyle,
//                       textAlign: TextAlign.center,
//                     )
//                   : CustomTextWidget(
//                       text: itemTextBuilder(entry.value),
//                       textThemeStyle: TextThemeStyleEnum.bodyMedium,
//                       color: Colors.black87,
//                       fontSize: Responsive.isTablet ? 10.sp : 15.sp,
//                       fontWeight: FontWeight.w500,
//                     ),
//             ),
//           ),
//         )
//             .toList(),
//         onChanged: onChanged,
//         selectedItemBuilder: selectedItemBuilder,

//         iconStyleData: IconStyleData(
//           iconSize: iconSize ?? 25.0.sp,
//           iconEnabledColor: iconEnabledColor,
//           iconDisabledColor: iconDisabledColor,
//         ),

//         buttonStyleData: ButtonStyleData(
//           height: buttonHeight ?? 40.h,
//           width: buttonWidth,
//           padding: buttonPadding ??
//               EdgeInsets.symmetric(
//                 horizontal: 11.0.w,
//                 vertical: 6.0.h,
//               ),
//           decoration: buttonDecoration ??
//               BoxDecoration(
//                 borderRadius: BorderRadius.circular(10.0.r),
//                 border: Border.all(
//                   color: Theme.of(context).colorScheme.primaryContainer,
//                 ),
//               ),
//           elevation: buttonElevation,
//         ),

//         menuItemStyleData: MenuItemStyleData(
//           height: itemHeight ?? 55.h,
//           padding: itemPadding ?? EdgeInsets.symmetric(vertical: 8.h, horizontal: 0),
//         ),

//         //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
//         dropdownStyleData: DropdownStyleData(
//           maxHeight: dropdownHeight ?? 450.0.h,
//           width: dropdownWidth ?? 240.w,
//           padding: dropdownPadding ?? EdgeInsets.zero,
//           decoration: dropdownDecoration ??
//               BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(30.0.r),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 20,
//                     offset: const Offset(0, 10),
//                   ),
//                 ],
//               ),
//           elevation: dropdownElevation ?? 8,
//           scrollbarTheme: ScrollbarThemeData(
//             thumbColor: WidgetStateProperty.all(Theme.of(context).colorScheme.primaryContainer),
//             radius: scrollbarRadius ?? Radius.circular(10.0.r),
//             thickness: WidgetStateProperty.all(scrollbarThickness ?? 8.0.w),
//             trackVisibility: WidgetStateProperty.all(
//               scrollbarAlwaysShow ?? true,
//             ),
//           ),
//           isOverButton: false, //Default is false to show menu below button
//         ),
//       ),
//     );
//   }
// }
