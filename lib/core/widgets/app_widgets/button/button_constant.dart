import 'package:flutter/material.dart';


class AppButtonPadding {
  /// Small (SM) button content padding.
  static const sm = EdgeInsets.symmetric(
    vertical: 8.0,
    horizontal: 14.0,
  );

  /// Medium (MD) button content padding.
  static const md = EdgeInsets.symmetric(
    vertical: 10.0,
    horizontal: 16.0,
  );

  /// Large (LG) button content padding.
  static const lg = EdgeInsets.symmetric(
    vertical: 10.0,
    horizontal: 18.0,
  );

  /// Extra Large (XL) button content padding.
  static const xl = EdgeInsets.symmetric(
    vertical: 12.0,
    horizontal: 20.0,
  );

  /// Extra Large 2 (2XL) button content padding.
  static const xl2 = EdgeInsets.symmetric(
    vertical: 16.0,
    horizontal: 28.0,
  );

  static EdgeInsetsGeometry fromButtonHeights(double buttonHeights) {
    if (buttonHeights <= AppButtonHeights.sm) {
      return sm;
    } else if (buttonHeights <= AppButtonHeights.md) {
      return md;
    } else if (buttonHeights <= AppButtonHeights.lg) {
      return lg;
    } else if (buttonHeights <= AppButtonHeights.xl) {
      return xl;
    } else {
      return xl2;
    }
  }
}

/// Possible content padding for icon-only buttons.
class AppButtonIconOnlyPadding {
  /// Small (SM) icon-only button content padding.
  static const sm = EdgeInsets.all(8.0);

  /// Medium (MD) icon-only button content padding.
  static const md = EdgeInsets.all(10.0);

  /// Large (LG) icon-only button content padding.
  static const lg = EdgeInsets.all(12.0);

  /// Extra Large (XL) icon-only button content padding.
  static const xl = EdgeInsets.all(14.0);

  /// Extra Large 2 (2XL) icon-only button content padding.
  static const xl2 = EdgeInsets.all(16.0);

  static EdgeInsetsGeometry fromButtonHeights(double buttonHeights) {
    if (buttonHeights <= AppButtonHeights.sm) {
      return sm;
    } else if (buttonHeights <= AppButtonHeights.md) {
      return md;
    } else if (buttonHeights <= AppButtonHeights.lg) {
      return lg;
    } else if (buttonHeights <= AppButtonHeights.xl) {
      return xl;
    } else {
      return xl2;
    }
  }
}

/// Possible icon size for buttons.
class AppButtonIconSize {
  static double fromButtonHeights(double buttonHeights) {
    if (buttonHeights <= AppButtonHeights.xl) {
      return 20.0;
    } else {
      return 24.0;
    }
  }
}

class AppButtonHeights {
  /// Small (SM) button height.
  static const double sm = 36.0;

  /// Medium (MD) button height.
  static const double md = 40.0;

  /// Large (LG) button height.
  static const double lg = 44.0;

  /// Extra Large (XL) button height.
  static const double xl = 48.0;

  /// Extra Large 2 (2XL) button height.
  static const double xl2 = 60.0;
}

class AppButtonTextFontSize {
  /// Small (SM) button text font size.
  static double sm = AppFontSizes.sm;

  /// Medium (MD) button text font size.
  static double md = AppFontSizes.sm;

  /// Large (LG) button text font size.
  static double lg = AppFontSizes.md;

  /// Extra Large (XL) button text font size.
  static double xl = AppFontSizes.md;

  /// Extra Large 2 (2XL) button text font size.
  static double xl2 = AppFontSizes.lg;

  static double fromButtonHeights(double buttonHeights) {
    if (buttonHeights <= AppButtonHeights.sm) {
      return sm;
    } else if (buttonHeights <= AppButtonHeights.md) {
      return md;
    } else if (buttonHeights <= AppButtonHeights.lg) {
      return lg;
    } else if (buttonHeights <= AppButtonHeights.xl) {
      return xl;
    } else {
      return xl2;
    }
  }
}
abstract class AppFontSizes {
  static double lg = 18;
  static double md = 16;
  static double sm = 14;
}
