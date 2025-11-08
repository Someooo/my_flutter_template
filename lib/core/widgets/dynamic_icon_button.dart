import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DynamicIconButton extends StatelessWidget {
  final Function()? onPressed;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final Widget widget;
  final double? opacity;
  final Color? backgroundColor;

  const DynamicIconButton({
    super.key,
     this.onPressed,
    this.height,
    this.width,
    this.margin,
    required this.widget,
    this.opacity,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height ?? 50.h,
      width: width ?? 50.w,
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: backgroundColor ??
            Theme.of(context).primaryColor.withValues( alpha: 
                  opacity ?? 0.2,
                ),
        shape: BoxShape.circle,
      ),
      margin: margin,
      child: IconButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: onPressed,
        icon: widget,
      ),
    );
  }
}
