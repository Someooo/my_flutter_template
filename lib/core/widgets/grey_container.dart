import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GreyContainer extends StatelessWidget {
  final Widget child;
  final double? size;
  const GreyContainer({super.key, required this.child, this.size});

  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(40.r),
                      border: Border.all(color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 8.0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: child,

    )
    ;
  }
}