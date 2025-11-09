import 'package:flutter/material.dart';

import 'circular_gauge_widget.dart';

class AppLiquidButtontoHome extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onTap;
  final double depth;
  final BorderRadius? borderRadius;
  final Color? color;
  final double? intensity;
  final EdgeInsets? padding;
  final String? label;
  final TextStyle? labelStyle;
  
  // Arc properties
  final bool showArc;
  final double? arcHeight;
  final double? arcWidth;
  final Color? arcColor;
  final double? arcStrokeWidth;
  
  // Gauge properties
  final bool showGauge;
  final double? gaugeValue;
  final double? gaugeMinValue;
  final double? gaugeMaxValue;
  final String? gaugeUnit;
  final double? gaugeSize;
  final Color? gaugeActiveColor;
  final Color? gaugeInactiveColor;
  final String? gaugeTitle;
 

  const AppLiquidButtontoHome(
      {super.key,
      this.child,
      this.onTap,
      this.depth = -5,
      this.borderRadius,
      this.color,
      this.intensity,
      this.padding,
      this.label,
      this.labelStyle,
      this.showArc = false,
      this.arcHeight,
      this.arcWidth,
      this.arcColor,
      this.arcStrokeWidth,
      this.showGauge = false,
      this.gaugeValue,
      this.gaugeMinValue,
      this.gaugeMaxValue,
      this.gaugeUnit,
      this.gaugeSize,
      this.gaugeActiveColor,
      this.gaugeInactiveColor,
      this.gaugeTitle,
      });

  @override
  Widget build(BuildContext context) {
    Widget content = child ?? const SizedBox.shrink();
    
    // If gauge is enabled, use gauge as content
    if (showGauge) {
      content = _buildGaugeContent();
    }
    // If arc is enabled, wrap content with arc
    else if (showArc) {
      content = _buildContentWithArc(content);
    }
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 80, // Fixed height for consistent alignment
          child: _LiquidButtonContainer(
            depth: depth,
            borderRadius: borderRadius ?? BorderRadius.circular(15),
            color: color,
            intensity: intensity,
            padding: padding,
            onTap: onTap,
            child: content,
          ),
        ),
        if (label != null) ...[
          const SizedBox(height: 4),
          SizedBox(
            height: 32, // Fixed height for label area (accommodates 2 lines)
            child: Text(
              label!,
              textAlign: TextAlign.center,
              maxLines: 2, // Allow up to 2 lines
              overflow: TextOverflow.ellipsis,
              style: labelStyle ??
                  const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
            ),
          ),
        ],
      ],
    );
  }
  
  Widget _buildGaugeContent() {
    return CircularGaugeWidget(
      value: gaugeValue ?? 0,
      minValue: gaugeMinValue ?? 0,
      maxValue: gaugeMaxValue ?? 300,
      size: gaugeSize ?? 200,
      activeColor: gaugeActiveColor ?? Colors.pink,
      inactiveColor: gaugeInactiveColor ?? Colors.grey,
      textColor: gaugeActiveColor ?? Colors.pink, 
      title: gaugeTitle,
    );
  }

  Widget _buildContentWithArc(Widget child) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Arc widget
        CustomPaint(
          size: Size(
            arcWidth ?? 100,
            arcHeight ?? 20,
          ),
          painter: ArcPainter(
            color: arcColor ?? Colors.blue,
            strokeWidth: arcStrokeWidth ?? 2.0,
          ),
        ),
        const SizedBox(height: 8), // Space between arc and content
        // Original content
        child,
      ],
    );
  }
}

// Custom painter for drawing the arc
class ArcPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  ArcPainter({
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final path = Path();
    
    // Create an arc that curves upward
    final rect = Rect.fromLTWH(0, size.height * 0.3, size.width, size.height * 0.7);
    path.addArc(rect, 0, 3.14159); // π radians = 180 degrees
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is ArcPainter &&
        (oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth);
  }
}

class _LiquidButtonContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double depth;
  final BorderRadius borderRadius;
  final Color? color;
  final double? intensity;
  final EdgeInsets? padding;

  const _LiquidButtonContainer({
    required this.child,
    required this.onTap,
    required this.depth,
    required this.borderRadius,
    required this.color,
    required this.intensity,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final double positiveDepth = depth.abs();
    final double resolvedIntensity = (intensity ?? 0.4).clamp(0, 1);

    return Material(
      color: Colors.transparent,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: color ?? Theme.of(context).colorScheme.surface,
            boxShadow: depth == 0
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: (0.08 + resolvedIntensity * 0.2).clamp(0, 1),
                      ),
                      blurRadius: positiveDepth * 4,
                      offset: Offset(0, positiveDepth),
                    ),
                    BoxShadow(
                      color: Colors.white.withValues(
                        alpha: (0.5 - resolvedIntensity.clamp(0, 0.4)).clamp(0, 1),
                      ),
                      blurRadius: positiveDepth * 3,
                      offset: Offset(0, -positiveDepth / 1.5),
                    ),
                  ],
          ),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(12),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
