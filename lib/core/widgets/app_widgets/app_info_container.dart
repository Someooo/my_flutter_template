import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/app_info_model.dart';
import 'app_container.dart';
import 'app_data_info_column.dart';
import 'app_data_info_row.dart';

class AppInfoContainer extends StatelessWidget {
  final List<AppInfoUIModel> dataList;
  final bool viewAsColumn;
  final bool viewAsColumnDivider;
  final double? width;
  final CrossAxisAlignment rowCrossAxisAlignment;
  final bool showBorder;
  final Color? borderColor;
  final bool showShadow;
  final double? shadowBlurRadius;
  final double? shadowSpreadRadius;
  final Offset? shadowOffset;
  final Color? shadowColor;
  final Color? background;

  const AppInfoContainer({
    super.key,
    required this.dataList,
    this.viewAsColumn = false,
    this.viewAsColumnDivider = false,
    this.width,
    this.rowCrossAxisAlignment = CrossAxisAlignment.center,
    this.showBorder = false,
    this.borderColor,
    this.showShadow = false,
    this.shadowBlurRadius,
    this.shadowSpreadRadius,
    this.shadowOffset,
    this.shadowColor,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      width: width,
      padding: EdgeInsets.all(15.r),
      color: background,
      decoration: (showBorder || showShadow)
          ? BoxDecoration(
              color: background ?? Colors.white,
              borderRadius: BorderRadius.circular(24.r),
              border: showBorder
                  ? Border.all(
                      color: borderColor ?? Colors.grey,
                      width: 1.w,
                    )
                  : null,
              boxShadow: showShadow
                  ? [
                      BoxShadow(
                        color: shadowColor ??
                            Colors.grey.withValues(alpha: 0.3),
                        blurRadius: shadowBlurRadius ?? 8.0.r,
                        spreadRadius: shadowSpreadRadius ?? 0.0.r,
                        offset: shadowOffset ?? Offset(0, 2.h),
                      ),
                    ]
                  : null,
            )
          : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: dataList.asMap().entries.map((entry) {
          int index = entry.key;
          AppInfoUIModel e = entry.value;

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5.h,
            children: [
              if (!viewAsColumn)
                AppDataInfoRow(
                    data: e, rowCrossAxisAlignment: rowCrossAxisAlignment)
              else
                AppDataInfoColumn(
                  data: e,
                  viewAsColumnDivider: viewAsColumnDivider,
                ),
              if (index != dataList.length - 1 && e.showDividerAfter)
                Divider(
                  color: Colors.grey.shade300,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
