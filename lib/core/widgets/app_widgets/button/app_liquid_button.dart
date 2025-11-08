// import 'dart:ui';

// import 'package:flutter/widgets.dart';
// import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

// class AppLiquidButton extends StatelessWidget {
//   final Widget child;
//   final VoidCallback onTap;
//   final NeumorphicShape? shape;
//   final double depth;
//   final NeumorphicBoxShape? boxShape;
//   final Color? color;
//   final double? intensity;
//   final EdgeInsets? padding;
//   final String? label;
//   final TextStyle? labelStyle;
 

//   const AppLiquidButton(
//       {super.key,
//       required this.child,
//       required this.onTap,
//       this.shape,
//       this.depth = 5,
//       this.boxShape,
//       this.color,
//       this.intensity,
//       this.padding,
//       this.label,
//       this.labelStyle,
    
//       });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         NeumorphicButton(
//           padding: padding,
//           style: NeumorphicStyle(
//             depth: depth,
//             boxShape: boxShape ??
//                 NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
//             shape: shape ?? NeumorphicShape.concave,
//             color: color ?? const Color(0xFFF7F7F7),
//             intensity: intensity ?? 0.4,
//             lightSource: const LightSource(1, 1),
//           ),
//           onPressed: onTap,
//           child: child,
//         ),
//               if (label != null) ...[
//           const SizedBox(height: 4),
//           Text(
//             label!,
//             textAlign: TextAlign.center,
//             style: labelStyle ??
//                 const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black87,
//                 ),
//           ),
//         ],
//       ],
//     );
//   }
// }
