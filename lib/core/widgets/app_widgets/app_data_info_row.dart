import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/app_info_model.dart';
import '../../utils/app_text_style.dart';

class AppDataInfoRow extends StatelessWidget {
  final AppInfoUIModel data;
  final CrossAxisAlignment rowCrossAxisAlignment;

  const AppDataInfoRow({
    required this.data,
    super.key,
    this.rowCrossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    // If photo exists and description is empty, render only the photo in full width
    final bool isPhotoOnly = data.photo != null && data.description.trim().isEmpty;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isPhotoOnly)
          Row(
            children: [data.photo!],
          )
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: rowCrossAxisAlignment,
            children: [
              if (data.photo != null)
                data.photo!
              else
                Text(
                  data.title??"",
                  style: data.titleStyle ?? AppTextStyle.subTitle,
                  overflow: data.titleOverflow ?? TextOverflow.ellipsis,
                  maxLines: data.titleMaxLines ?? 1,
                ),
              SizedBox(width: 8.w),
              if (data.isMarked)
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    padding: EdgeInsets.all(5.r),
                    child: Text(
                      data.description,
                      style: data.descriptionStyle ??
                          AppTextStyle.subTitle.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                      overflow: data.descriptionOverflow ??
                          TextOverflow.ellipsis,
                      maxLines: data.descriptionMaxLines ?? 1,
                    ),
                  ),
                )
              else
                Expanded(
                  child: Text(
                    data.description,
                    style: data.descriptionStyle ??
                        AppTextStyle.subTitle.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                    overflow: data.descriptionOverflow ??
                        TextOverflow.ellipsis,
                    maxLines: data.descriptionMaxLines ?? 1,
                  ),
                ),
            ],
          ),
        if (data.descriptionsList != null && data.descriptionsList!.isNotEmpty)
          ...data.descriptionsList!.map(
            (e) => Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.title??"",
                    style: e.titleStyle ?? AppTextStyle.subTitle,
                    overflow: e.titleOverflow ?? TextOverflow.ellipsis,
                    maxLines: e.titleMaxLines ?? 1,
                  ),
                  if (e.isMarked)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      padding: EdgeInsets.all(5.r),
                      child: Text(
                        e.description,
                        style: e.descriptionStyle ??
                            AppTextStyle.subTitle.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                        overflow: e.descriptionOverflow ??
                            TextOverflow.ellipsis,
                        maxLines: e.descriptionMaxLines ?? 1,
                      ),
                    )
                  else
                    Text(
                      e.description,
                      style: e.descriptionStyle ??
                          AppTextStyle.subTitle.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                      overflow: e.descriptionOverflow ??
                          TextOverflow.ellipsis,
                      maxLines: e.descriptionMaxLines ?? 1,
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
