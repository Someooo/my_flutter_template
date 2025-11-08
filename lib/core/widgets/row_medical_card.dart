import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/responsive.dart';
import 'custom_text_widget.dart';

class RowMedicalCard extends StatelessWidget {
  final String data;
    final String ? title;

  const RowMedicalCard ({super.key, required this.data, this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
              children: [
                SizedBox(width: 25.w),
               CustomTextWidget(text: title ?? "", fontWeight: FontWeight.w500, fontSize: Responsive.isTablet? 6.sp :15.sp,  color: const Color(0xff8C8C8C),),

               CustomTextWidget(text: data , fontWeight: FontWeight.w500, fontSize: Responsive.isTablet? 6.sp :13.sp,  color: const Color(0xff8C8C8C),)
              ],
              
            );
  }
}