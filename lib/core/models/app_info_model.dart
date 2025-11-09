import 'package:flutter/widgets.dart';

class AppInfoUIModel {
  final String? title;
  final TextStyle? titleStyle;
  final TextOverflow? titleOverflow;
  final int? titleMaxLines;
  final Widget? photo;
  final String description;
  final TextStyle? descriptionStyle;
  final TextOverflow? descriptionOverflow;
  final int? descriptionMaxLines;
  final bool isMarked;
  final bool showDividerAfter;
  final List<AppInfoUIModel>? descriptionsList;

  const AppInfoUIModel({
    this.title,
    this.titleStyle,
    this.titleOverflow,
    this.titleMaxLines,
    this.photo,
    this.description = '',
    this.descriptionStyle,
    this.descriptionOverflow,
    this.descriptionMaxLines,
    this.isMarked = false,
    this.showDividerAfter = false,
    this.descriptionsList,
  });
}

