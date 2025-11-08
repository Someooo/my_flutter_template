import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDivider extends StatelessWidget {
  final double? height;

  const CustomDivider({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: const Color(0XFFCBD5E1),
      height: height ?? 1.h,
    );
  }
}
