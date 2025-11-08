import 'package:flutter/material.dart';

class CircularGaugeWidget extends StatelessWidget {
  final double value;
  final double minValue;
  final double maxValue;
  final String unit;
  final double size;
  final Color activeColor;
  final Color inactiveColor;
  final Color textColor;
  final double strokeWidth;
  final String? title;

  const CircularGaugeWidget({
    super.key,
    required this.value,
    this.minValue = 0,
    this.maxValue = 240,
    this.unit = 'km/h',
    this.size = 200,
    this.activeColor = Colors.pink,
    this.inactiveColor = Colors.grey,
    this.textColor = Colors.white,
    this.strokeWidth = 4, // Reduced from 12 to 8
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: CustomPaint(
        size: Size(size, size),
        painter: CircularGaugePainter(
          value: value,
          minValue: minValue,
          maxValue: maxValue,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          textColor: textColor,
          strokeWidth: strokeWidth,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (title != null) ...[
                Text(
                  title!,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
              ],
              const SizedBox(height: 8), // Add space above the number
              Text(
                value.toInt().toString(),
                style: TextStyle(
                  color: textColor,
                  fontSize: 26,
                ),
              ),
              // Unit text removed - only show the number
            ],
          ),
        ),
      ),
    );
  }
}

class CircularGaugePainter extends CustomPainter {
  final double value;
  final double minValue;
  final double maxValue;
  final Color activeColor;
  final Color inactiveColor;
  final Color textColor;
  final double strokeWidth;

  CircularGaugePainter({
    required this.value,
    required this.minValue,
    required this.maxValue,
    required this.activeColor,
    required this.inactiveColor,
    required this.textColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 1.6;

    // Calculate the angle for the current value
    final valueRange = maxValue - minValue;
    final normalizedValue = (value - minValue) / valueRange;
    final sweepAngle = normalizedValue * 180; // 180 degrees for semi-circle

    // Draw base arc (lighter shade of number color)
    final basePaint = Paint()
      ..color = textColor.withOpacity(0.3) // Lighter shade of the number color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final arcRect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(
      arcRect,
      -3.14159, // Start from left (0 degrees) - π radians
      3.14159, // 180 degrees - π radians
      false,
      basePaint,
    );

    // Draw progress arc (same color as number)
    if (sweepAngle > 0) {
      final progressPaint = Paint()
        ..color = textColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        arcRect,
        -3.14159, // Start from left
        sweepAngle * 3.14159 / 180, // Convert to radians
        false,
        progressPaint,
      );
    }

    // Value indicator dot removed as requested

    // No labels - clean gauge with just the arc and value
  }

  // Simple trigonometric functions to avoid math import issues
  double _cos(double radians) {
    // Approximation for common angles
    if (radians == 0) return 1.0;
    if (radians == 3.14159 / 2) return 0.0;
    if (radians == 3.14159) return -1.0;
    if (radians == 3 * 3.14159 / 2) return 0.0;
    
    // For other angles, use a simple approximation
    return 1 - (radians * radians) / 2 + (radians * radians * radians * radians) / 24;
  }

  double _sin(double radians) {
    // Approximation for common angles
    if (radians == 0) return 0.0;
    if (radians == 3.14159 / 2) return 1.0;
    if (radians == 3.14159) return 0.0;
    if (radians == 3 * 3.14159 / 2) return -1.0;
    
    // For other angles, use a simple approximation
    return radians - (radians * radians * radians) / 6 + (radians * radians * radians * radians * radians) / 120;
  }

  void _drawLabel(Canvas canvas, Offset center, double radius, double angle, String text) {
    final labelRadius = radius + 20;
    final radians = angle * 3.14159 / 180;
    final labelX = center.dx + labelRadius * _cos(radians);
    final labelY = center.dy + labelRadius * _sin(radians);

    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        labelX - textPainter.width / 2,
        labelY - textPainter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is CircularGaugePainter &&
        (oldDelegate.value != value ||
            oldDelegate.activeColor != activeColor ||
            oldDelegate.inactiveColor != inactiveColor);
  }
}