import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'custom_text_widget.dart';

class IconAndText extends StatelessWidget {
  final String title;
  final IconData icon;
  const IconAndText({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return   Row(
              children: [
               Icon(icon , color: Colors.black, size: 23.sp),
                SizedBox(width: 3.w),
               CustomTextWidget(text: title.tr , fontWeight: FontWeight.w600,)
              ],
        
            );
  }
}