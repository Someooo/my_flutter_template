import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppContainer extends StatelessWidget {
  final Widget? child;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? color;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BoxDecoration? decoration;
  final bool isLiquid;

  const AppContainer({
    super.key,
    this.child,
    this.height,
    this.width,
    this.color,
    this.padding,
    this.margin,
    this.decoration,
    this.borderRadius,
    this.isLiquid = false,
  });

  factory AppContainer.liquid({
    Key? key,
    Widget? child,
    double? height,
    double? width,
    Color? color,
    EdgeInsets? padding,
    double? borderRadius,
    BoxDecoration? decoration,
  }) {
    return AppContainer(
      key: key,
      height: height,
      width: width,
      padding: padding,
      decoration: decoration,
      borderRadius: borderRadius,
      isLiquid: true,
      color: color,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadius resolvedBorderRadius =
        BorderRadius.circular((borderRadius ?? 24).r);

    final Widget container = Container(
      width: width,
      height: height,
      margin: margin ?? EdgeInsets.all(10.r),
      padding: padding ?? EdgeInsets.all(10.r),
      decoration: decoration ??
          BoxDecoration(
            color: color ?? Theme.of(context).colorScheme.surface,
            borderRadius: resolvedBorderRadius,
          ),
      child: child,
    );

    if (!isLiquid) return container;

    final Color shadowColor =
        (color ?? Theme.of(context).colorScheme.surface).withValues(alpha: 0.6);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: resolvedBorderRadius,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 16.r,
            spreadRadius: 0,
            offset: Offset(0, 8.h),
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.4),
            blurRadius: 12.r,
            spreadRadius: -6.r,
            offset: Offset(0, -4.h),
          ),
        ],
      ),
      child: container,
    );
  }
}
