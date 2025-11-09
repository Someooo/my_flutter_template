import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/asset_paths.dart';
import '../utils/responsive.dart';
import 'custom_text_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.backgroundColor = Colors.transparent,
    this.leading,
    this.centerTitle = true,
    this.bottom,
    this.flexibleSpace,
    this.popPath,
    this.popOnePage,
    this.onBack,
    this.actions,
    this.systemUI,
    this.appIcon = false,
    this.titleHeroTag,
    this.leadingWidth,
    this.automaticallyImplyLeading = true,
  });

  final String title;
  final SystemUiOverlayStyle? systemUI;
  final Color backgroundColor;
  final Widget? leading;
  final bool centerTitle;
  final PreferredSizeWidget? bottom;
  final Widget? flexibleSpace;
  final String? popPath;
  final bool? popOnePage;
  final bool appIcon;

  final VoidCallback? onBack;
  final List<Widget>? actions;
  final String? titleHeroTag;
  final double? leadingWidth;
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      systemOverlayStyle: systemUI ?? SystemUiOverlayStyle.dark,
      actions: actions,
      flexibleSpace: flexibleSpace,
      leadingWidth: leadingWidth ?? 50.w,
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: centerTitle,
      leading: leading,
      // automaticallyImplyLeading ? (leading ?? _buildBackButton()) : null,
      title: appIcon
          ? Image.asset(
              AssetPaths.youtubePng,
              height: 40.h,
            )
          : titleHeroTag != null
              ? Hero(
                  tag: titleHeroTag!,
                  child: CustomTextWidget(
                    text: title,
                   fontSize: Responsive.isTablet? 6.sp : 18
                  ),
                )
              : CustomTextWidget(
                  text: title,
                  fontSize: Responsive.isTablet? 6.sp : 18
                ),
      bottom: bottom,
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
