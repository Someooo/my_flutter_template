import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../enums/text_style_enum.dart';
import 'custom_row.dart';
import 'custom_text_widget.dart';
import '../models/medical_form_model.dart';

class CustomExpansionTile extends StatelessWidget {
  final String title;
  final String notes;
  final List<Item>? items;

  const CustomExpansionTile({super.key, required this.title, required this.notes, required this.items});

  @override
  Widget build(BuildContext context) {
    return CustomExpansionDesign(
      text: title,
      children: [
        if (notes.isNotEmpty) ...[
          Align(
            alignment: Get.locale?.languageCode == "ar" ? Alignment.centerRight : Alignment.centerLeft,
            child: CustomTextWidget(
              text: notes,
              textThemeStyle: TextThemeStyleEnum.displaySmall,
              fontWeight: FontWeight.w500,
              height: 1.2,
              maxLines: 10,
            ),
          ),
          SizedBox(height: 5.h),
        ],
        Column(
          children: List.generate(
            items?.length ?? 0,
            (index) {
              final item = items![index];
              return Container(
                padding: EdgeInsets.only(bottom: 15.h),
                // color: Colors.pink,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 15.w,
                  children: [
                    CustomTextWidget(
                      text: "${index + 1})",
                      textThemeStyle: TextThemeStyleEnum.displaySmall,
                      fontWeight: FontWeight.w500,
                    ),
                    Expanded(
                      child: Column(
                        spacing: 2.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextWidget(
                            text: item.name ?? "",
                            textThemeStyle: TextThemeStyleEnum.displaySmall,
                            fontWeight: FontWeight.w500,
                            maxLines: 2,
                          ),
                          HeadingWithValue(
                            heading: 'price',
                            value: "${item.price}",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );

    // return ExpansionTile(
    //   dense: true,
    //   expandedAlignment: Alignment.centerLeft,
    //   iconColor: Get.theme.colorScheme.secondary,
    //   collapsedIconColor: Get.theme.colorScheme.secondary,
    //   // background colors
    //   backgroundColor: Get.theme.colorScheme.onTertiaryContainer,
    //   collapsedBackgroundColor: Get.theme.primaryColor.withAlpha(50),
    //
    //   childrenPadding: EdgeInsets.symmetric(horizontal: 15.w),
    //   tilePadding: EdgeInsets.symmetric(horizontal: 12.w),
    //   collapsedShape: Border.all(color: borderColor),
    //   shape: Border.all(color: borderColor),
    //   initiallyExpanded: false,
    //   title: CustomTextWidget(
    //     text: title,
    //     textThemeStyle: TextThemeStyleEnum.displayMedium,
    //   ),
    //   children: [
    //     if (notes.isNotEmpty) ...[
    //       Align(
    //         alignment: Get.locale?.languageCode == "ar" ? Alignment.centerRight : Alignment.centerLeft,
    //         child: CustomTextWidget(
    //           text: notes,
    //           textThemeStyle: TextThemeStyleEnum.displaySmall,
    //           fontWeight: FontWeight.w500,
    //           height: 1.2,
    //           maxLines: 10,
    //         ),
    //       ),
    //       SizedBox(height: 5.h),
    //     ],
    //     Column(
    //       children: List.generate(
    //         items?.length ?? 0,
    //         (index) {
    //           final item = items![index];
    //           return Container(
    //             padding: EdgeInsets.only(bottom: 15.h),
    //             // color: Colors.pink,
    //             child: Row(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               spacing: 15.w,
    //               children: [
    //                 CustomTextWidget(
    //                   text: "${index + 1})",
    //                   textThemeStyle: TextThemeStyleEnum.displaySmall,
    //                   fontWeight: FontWeight.w500,
    //                 ),
    //                 Expanded(
    //                   child: Column(
    //                     spacing: 2.h,
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       CustomTextWidget(
    //                         text: item.name ?? "",
    //                         textThemeStyle: TextThemeStyleEnum.displaySmall,
    //                         fontWeight: FontWeight.w500,
    //                         maxLines: 2,
    //                       ),
    //                       HeadingWithValue(
    //                         heading: 'price',
    //                         value: "${item.price}",
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           );
    //         },
    //       ),
    //     )
    //   ],
    // );
  }
}

class CustomExpansionDesign extends StatelessWidget {
  final String text;
  final List<Widget> children;

  const CustomExpansionDesign({super.key, required this.text, required this.children});

  @override
  Widget build(BuildContext context) {
    final borderColor = Get.theme.primaryColor.withAlpha(150);

    return ExpansionTile(
      dense: true,
      expandedAlignment: Alignment.centerLeft,
      iconColor: Get.theme.colorScheme.secondary,
      collapsedIconColor: Get.theme.colorScheme.secondary,
      backgroundColor: Get.theme.colorScheme.onTertiaryContainer,
      collapsedBackgroundColor: Get.theme.primaryColor.withAlpha(50),
      childrenPadding: EdgeInsets.symmetric(horizontal: 15.w),
      tilePadding: EdgeInsets.symmetric(horizontal: 12.w),

      // 🟢 Border radius + border color
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(color: borderColor),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(color: borderColor),
      ),

      initiallyExpanded: false,
      title: CustomTextWidget(
        text: text,
        textThemeStyle: TextThemeStyleEnum.displayMedium,
      ),
      children: children,
    );
  }
}
