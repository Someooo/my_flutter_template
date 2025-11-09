import 'package:flutter/widgets.dart';

extension GapExtension on num {
  SizedBox get gap => SizedBox(
        height: toDouble(),
        width: toDouble(),
      );

  SizedBox get vGap => SizedBox(height: toDouble());

  SizedBox get hGap => SizedBox(width: toDouble());
}

