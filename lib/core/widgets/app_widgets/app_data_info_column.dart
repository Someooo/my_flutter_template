import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/app_info_model.dart';
import '../../utils/app_text_style.dart';

class AppDataInfoColumn extends StatelessWidget {
  final AppInfoUIModel data;
  final bool viewAsColumnDivider;

  const AppDataInfoColumn(
      {required this.data, super.key, required this.viewAsColumnDivider});

  @override
  Widget build(BuildContext context) {
    // If photo exists and description is empty, render only the photo
    final bool isPhotoOnly = data.photo != null && data.description.trim().isEmpty;
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.h,
      children: [
        if (data.photo != null)
          data.photo!
        else
          Text(
            data.title??"",

            textAlign: TextAlign.start,
            style: data.titleStyle ?? AppTextStyle.subTitle,
          ),
        if (!isPhotoOnly && viewAsColumnDivider)
          Divider(
            color: Colors.grey.shade300,
          ),
        if (!isPhotoOnly && data.isMarked)
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(5.r),
            ),
            padding: EdgeInsets.all(5.r),
            child: Text(
              data.description,
              style: data.descriptionStyle ?? AppTextStyle.style14B,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        else if (!isPhotoOnly)
          Text(
            data.description,
            style: data.descriptionStyle ?? AppTextStyle.style14B,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
      ],
    );
  }
}
