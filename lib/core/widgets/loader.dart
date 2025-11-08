import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader1 extends StatelessWidget {
  final Color? color;

  const Loader1({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: color ?? Colors.black,
      ),
    );
  }
}

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: Stack(
              children: [
                // Blur effect (optional)
                Container(
                  color: Colors.black.withValues(alpha: 0.5), // Overlay color with opacity
                  child: const Center(
                    child: CircularProgressIndicator(), // Loading indicator
                  ),
                ),
                // Uncomment below if you want a blur effect (requires flutter_blurhash package)
                // BlurHash(
                //   hash: 'LEHV6nWB9YUn5pD4s;0t5xX6fRkD6X6Q0', // Example hash, replace with your own
                //   imageFit: BoxFit.cover,
                // ),
              ],
            ),
          ),
      ],
    );
  }
}

class LoadingFadingCircle extends StatelessWidget {
  final Color? color;

  const LoadingFadingCircle({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    final spinkit = SpinKitFadingCircle(
      color: color ?? Theme.of(context).colorScheme.primary,
      // itemBuilder: (BuildContext context, int index) {
      //   return DecoratedBox(
      //     decoration: BoxDecoration(
      //       color: index.isEven ? SharedColors.primaryColor : Colors.black,
      //     ),
      //   );
      // },
    );
    return SizedBox(
      width: 40.w,
      child: spinkit,
    );
  }
}
