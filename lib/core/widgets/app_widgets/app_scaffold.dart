import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../../utils/app_text_style.dart';
import '../../utils/responsive.dart';

class AppScaffold extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final bool showBackButton;
  final bool showBackButtonContainer;
  final bool showAppBar;
  final Widget body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;
  final PreferredSizeWidget? appBar;
  final VoidCallback? onBackPressed;

  const AppScaffold(
      {super.key,
      this.title,
      this.titleWidget,
      this.actions,
      this.showBackButton = true,
      this.showAppBar = true,
      this.showBackButtonContainer = true,
      this.resizeToAvoidBottomInset = true,
      required this.body,
      this.floatingActionButton,
      this.bottomNavigationBar,
      this.drawer,
      this.backgroundColor,
      this.appBar,
      this.endDrawer,
      this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppLightColors.primaryLightColor,
      drawerScrimColor: Colors.white.withValues(alpha: 0.9),
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: appBar ??
          (showAppBar
              ? AppBar(
                  title: titleWidget ??
                      (title != null
                          ? Text(
                              title!,
                              style: AppTextStyle.style16B.copyWith(
                                color: Colors.black,
                                fontSize: Responsive.isTablet ? 30 : 16,
                              ),
                            )
                          : null),
                  centerTitle: true,
                  actions: actions,
                  automaticallyImplyLeading: showBackButton,
                  backgroundColor: Colors.transparent,
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.dark,
                    statusBarBrightness: Brightness.light,
                  ),
                  leading: showBackButton
                      ? InkWell(
                          onTap: onBackPressed ?? () => Get.back(),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child:  Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.black,
                            size: Responsive.isTablet? 18.sp : 25.sp,

                          )
                          // Container(
                          //     height: 20,
                          //     width: 20,
                          //     margin: const EdgeInsets.all(7),
                          //     decoration: showBackButtonContainer
                          //         ? BoxDecoration(
                          //             color:AppLightColors.primaryLightColor,
                          //             borderRadius: BorderRadius.circular(70),
                          //             boxShadow: [
                          //               BoxShadow(
                          //                 color: Colors.grey
                          //                     .withValues(alpha: 0.5),
                          //                 spreadRadius: 1,
                          //                 blurRadius: 2,
                          //                 offset: const Offset(-1, 0),
                          //               ),
                          //             ],
                          //           )
                          //         : null,
                          //     child: const Icon(
                          //       Icons.arrow_back_ios_new_rounded,
                          //       color: Colors.black,
                          //     )
                          //     ),
                          )
                      : null,
                )
              : null),
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      drawer: drawer,
      endDrawer: endDrawer,
    );
  }
}
