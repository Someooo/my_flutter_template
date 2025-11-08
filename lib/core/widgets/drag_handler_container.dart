import '../../config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DragHandlerContainer extends StatelessWidget {
  const DragHandlerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: SharedColors.greyTextColor,
      ),
      height: 5.h,
      width: 40.w,
    );
  }
}
