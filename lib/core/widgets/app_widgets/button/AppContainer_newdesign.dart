// import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
// import '../gauge/circular_gauge_widget.dart';

// class AppContainer extends StatelessWidget {
//   final Widget? child;
//   final double? height;
//   final double? width;
//   final double? borderRadius;
//   final Color? color;
//   final EdgeInsets? padding;
//   final EdgeInsets? margin;
//   final BoxDecoration? decoration;
//   final bool isLiquid;
  
//   // Arc properties
//   final bool showArc;
//   final double? arcHeight;
//   final double? arcWidth;
//   final Color? arcColor;
//   final double? arcStrokeWidth;
  
//   // Gauge properties
//   final bool showGauge;
//   final double? gaugeValue;
//   final double? gaugeMinValue;
//   final double? gaugeMaxValue;
//   final String? gaugeUnit;
//   final double? gaugeSize;
//   final Color? gaugeActiveColor;
//   final Color? gaugeInactiveColor;
//   final String? gaugeTitle;

//   const AppContainer({
//     super.key,
//     this.child,
//     this.height,
//     this.width,
//     this.color,
//     this.padding,
//     this.margin,
//     this.decoration,
//     this.borderRadius,
//     this.isLiquid = false,
//     this.showArc = false,
//     this.arcHeight,
//     this.arcWidth,
//     this.arcColor,
//     this.arcStrokeWidth,
//     this.showGauge = false,
//     this.gaugeValue,
//     this.gaugeMinValue,
//     this.gaugeMaxValue,
//     this.gaugeUnit,
//     this.gaugeSize,
//     this.gaugeActiveColor,
//     this.gaugeInactiveColor,
//     this.gaugeTitle,
//   });

//   factory AppContainer.liquid({
//     Key? key,
//     Widget? child,
//     double? height,
//     double? width,
//     Color? color,
//     EdgeInsets? padding,
//     double? borderRadius,
//     BoxDecoration? decoration,
//     bool showArc = false,
//     double? arcHeight,
//     double? arcWidth,
//     Color? arcColor,
//     double? arcStrokeWidth,
//     bool showGauge = false,
//     double? gaugeValue,
//     double? gaugeMinValue,
//     double? gaugeMaxValue,
//     String? gaugeUnit,
//     double? gaugeSize,
//     Color? gaugeActiveColor,
//     Color? gaugeInactiveColor,
//     String? gaugeTitle,
//   }) {
//     return AppContainer(
//       key: key,
//       height: height,
//       width: width,
//       padding: padding,
//       decoration: decoration,
//       borderRadius: borderRadius,
//       isLiquid: true,
//       color: color,
//       child: child,
//       showArc: showArc,
//       arcHeight: arcHeight,
//       arcWidth: arcWidth,
//       arcColor: arcColor,
//       arcStrokeWidth: arcStrokeWidth,
//       showGauge: showGauge,
//       gaugeValue: gaugeValue,
//       gaugeMinValue: gaugeMinValue,
//       gaugeMaxValue: gaugeMaxValue,
//       gaugeUnit: gaugeUnit,
//       gaugeSize: gaugeSize,
//       gaugeActiveColor: gaugeActiveColor,
//       gaugeInactiveColor: gaugeInactiveColor,
//       gaugeTitle: gaugeTitle,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget content = child ?? const SizedBox.shrink();
    
//     // If gauge is enabled, use gauge as content
//     if (showGauge) {
//       content = _buildGaugeContent();
//     }
//     // If arc is enabled, wrap content with arc
//     else if (showArc) {
//       content = _buildContentWithArc(content);
//     }
    
//     Widget container = Container(
//       width: width,
//       height: height,
//       margin: margin ?? EdgeInsets.zero, // Remove default margin
//       padding: padding ?? const EdgeInsets.all(10),
//       decoration: decoration ??
//           BoxDecoration(
//             color: color ?? Colors.white,
//             borderRadius: BorderRadius.circular(borderRadius ?? 24),
//           ),
//       child: content,
//     );

//     if (isLiquid) {
//       return Neumorphic(
//         style: NeumorphicStyle(
//           shape: NeumorphicShape.concave,
//           depth: 8,
//           intensity: 0.6,
//           boxShape: NeumorphicBoxShape.roundRect(
//               BorderRadius.circular(borderRadius ?? 24)),
//         ),
//         child: container,
//       );
//     }

//     return container;
//   }
  
//   Widget _buildGaugeContent() {
//     return CircularGaugeWidget(
//       value: gaugeValue ?? 0,
//       minValue: gaugeMinValue ?? 0,
//       maxValue: gaugeMaxValue ?? 300,
//       // unit: gaugeUnit ?? 'km/h',
//       size: gaugeSize ?? 200,
//       activeColor: gaugeActiveColor ?? Colors.pink,
//       inactiveColor: gaugeInactiveColor ?? Colors.grey,
//       textColor: gaugeActiveColor ?? Colors.pink, // Use same color as arc
//       title: gaugeTitle,
//     );
//   }

//   Widget _buildContentWithArc(Widget child) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         // Arc widget
//         CustomPaint(
//           size: Size(
//             arcWidth ?? 100,
//             arcHeight ?? 20,
//           ),
//           painter: ArcPainter(
//             color: arcColor ?? Colors.blue,
//             strokeWidth: arcStrokeWidth ?? 2.0, // Reduced from 3.0 to 2.0
//           ),
//         ),
//         const SizedBox(height: 8), // Space between arc and content
//         // Original content
//         child,
//       ],
//     );
//   }
// }

// // Custom painter for drawing the arc
// class ArcPainter extends CustomPainter {
//   final Color color;
//   final double strokeWidth;

//   ArcPainter({
//     required this.color,
//     required this.strokeWidth,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = strokeWidth
//       ..strokeCap = StrokeCap.round;

//     final path = Path();
    
//     // Create an arc that curves upward
//     final rect = Rect.fromLTWH(0, size.height * 0.3, size.width, size.height * 0.7);
//     path.addArc(rect, 0, 3.14159); // π radians = 180 degrees
    
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return oldDelegate is ArcPainter &&
//         (oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth);
//   }
// }
