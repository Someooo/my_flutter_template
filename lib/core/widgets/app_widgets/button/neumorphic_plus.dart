import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';

/// Height constants for responsive AppOvalButton
class AppOvalButtonHeights {
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

/// Proportional width calculator based on height
class AppOvalButtonWidth {
  /// Calculates width proportionally from height (maintains ~2.5:1 aspect ratio)
  static double fromHeight(double height) {
    if (height <= AppOvalButtonHeights.sm) {
      return 100.0;  // sm
    } else if (height <= AppOvalButtonHeights.md) {
      return 110.0; // md
    } else if (height <= AppOvalButtonHeights.lg) {
      return 120.0; // lg
    } else if (height <= AppOvalButtonHeights.xl) {
      return 140.0; // xl
    } else {
      return 170.0; // xl2
    }
  }
}

/// Proportional depth calculator based on height
class AppOvalButtonDepth {
  /// Calculates neumorphic depth proportionally from height
  static double fromHeight(double height) {
    if (height <= AppOvalButtonHeights.md) {
      return 3.0;  // sm & md
    } else if (height <= AppOvalButtonHeights.lg) {
      return 4.0;  // lg
    } else if (height <= AppOvalButtonHeights.xl) {
      return 5.0;  // xl
    } else {
      return 6.0;  // xl2
    }
  }
}

/// Proportional padding calculator based on height
class AppOvalButtonPadding {
  /// Small (SM) button padding.
  static const sm = EdgeInsets.symmetric(
    vertical: 6.0,
    horizontal: 12.0,
  );

  /// Medium (MD) button padding.
  static const md = EdgeInsets.symmetric(
    vertical: 8.0,
    horizontal: 14.0,
  );

  /// Large (LG) button padding.
  static const lg = EdgeInsets.symmetric(
    vertical: 10.0,
    horizontal: 16.0,
  );

  /// Extra Large (XL) button padding.
  static const xl = EdgeInsets.symmetric(
    vertical: 12.0,
    horizontal: 18.0,
  );

  /// Extra Large 2 (2XL) button padding.
  static const xl2 = EdgeInsets.symmetric(
    vertical: 14.0,
    horizontal: 20.0,
  );

  static EdgeInsets fromHeight(double height) {
    if (height <= AppOvalButtonHeights.sm) {
      return sm;
    } else if (height <= AppOvalButtonHeights.md) {
      return md;
    } else if (height <= AppOvalButtonHeights.lg) {
      return lg;
    } else if (height <= AppOvalButtonHeights.xl) {
      return xl;
    } else {
      return xl2;
    }
  }
}

/// Proportional font size calculator for button text
class AppOvalButtonTextFontSize {
  /// Calculates appropriate font size based on button height
  static double fromHeight(double height) {
    if (height <= AppOvalButtonHeights.sm) {
      return 12.0; // sm
    } else if (height <= AppOvalButtonHeights.md) {
      return 13.0; // md
    } else if (height <= AppOvalButtonHeights.lg) {
      return 14.0; // lg
    } else if (height <= AppOvalButtonHeights.xl) {
      return 15.0; // xl
    } else {
      return 16.0; // xl2
    }
  }
}

/// Proportional icon size calculator for button icons
class AppOvalButtonIconSize {
  /// Calculates appropriate icon size based on button height
  static double fromHeight(double height) {
    if (height <= AppOvalButtonHeights.sm) {
      return 16.0; // sm
    } else if (height <= AppOvalButtonHeights.md) {
      return 18.0; // md
    } else if (height <= AppOvalButtonHeights.lg) {
      return 20.0; // lg
    } else if (height <= AppOvalButtonHeights.xl) {
      return 22.0; // xl
    } else {
      return 24.0; // xl2
    }
  }
}

// sami widget use this in main & add*edit promotion select image field 
class AppOvalButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double width;
  final double height;
  final double depth;
  final Color? color;
  final double? intensity;
  final EdgeInsets? padding;
  final NeumorphicBoxShape? boxShape;

  /// Standard constructor - maintains full backward compatibility
  const AppOvalButton({
    super.key,
    required this.child,
    this.onTap,
    this.width = 200,
    this.height = 50,
    this.depth = 5,
    this.color,
    this.intensity,
    this.padding,
    this.boxShape,
  });

  /// Responsive constructor - automatically calculates proportions from height
  /// 
  /// Example:
  /// ```dart
  /// AppOvalButton.responsive(
  ///   height: AppOvalButtonHeights.lg,
  ///   onTap: () {},
  ///   child: Text('Button'),
  /// )
  /// ```
  factory AppOvalButton.responsive({
    Key? key,
    required Widget child,
    VoidCallback? onTap,
    double height = AppOvalButtonHeights.md,
    double? width, // Optional override
    double? depth, // Optional override
    Color? color,
    double? intensity,
    EdgeInsets? padding, // Optional override
    NeumorphicBoxShape? boxShape,
  }) {
    return AppOvalButton(
      key: key,
      child: child,
      onTap: onTap,
      width: width ?? AppOvalButtonWidth.fromHeight(height),
      height: height,
      depth: depth ?? AppOvalButtonDepth.fromHeight(height),
      color: color,
      intensity: intensity,
      padding: padding ?? AppOvalButtonPadding.fromHeight(height),
      boxShape: boxShape,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: NeumorphicButton(
        padding: padding,
        style: NeumorphicStyle(
          depth: depth,
          boxShape: boxShape ?? const NeumorphicBoxShape.stadium(),
          shape: NeumorphicShape.concave,
          color: color ?? const Color(0xFFF7F7F7),
          intensity: intensity ?? 0.4,
          lightSource: const LightSource(1, 1),
        ),
        onPressed: onTap,
        child: Center(child: child),
      ),
    );
  }
}
