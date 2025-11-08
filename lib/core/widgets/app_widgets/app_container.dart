import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
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
    Widget container = Container(
      width: width,
      height: height,
      margin: margin ?? EdgeInsets.all(10.r),
      padding: padding ?? EdgeInsets.all(10.r),
      decoration: decoration ??
          BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: BorderRadius.circular((borderRadius ?? 24).r),
          ),
      child: child,
    );

    if (isLiquid) {
      return Neumorphic(
        style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          depth: 8,
          intensity: 0.6,
          boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular((borderRadius ?? 24).r)),
        ),
        child: container,
      );
    }

    return container;
  }
}
