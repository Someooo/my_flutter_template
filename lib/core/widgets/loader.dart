import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Loader1 extends StatelessWidget {
  final Color? color;

  const Loader1({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final Color? overlayColor;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.overlayColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color resolvedOverlayColor =
        overlayColor ?? Colors.black.withValues(alpha: 0.35);

    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: ColoredBox(
              color: resolvedOverlayColor,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
      ],
    );
  }
}

class LoadingFadingCircle extends StatefulWidget {
  final Color? color;

  const LoadingFadingCircle({super.key, this.color});

  @override
  State<LoadingFadingCircle> createState() => _LoadingFadingCircleState();
}

class _LoadingFadingCircleState extends State<LoadingFadingCircle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))
        ..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color indicatorColor =
        widget.color ?? Theme.of(context).colorScheme.primary;

    return SizedBox(
      width: 40.w,
      height: 40.w,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final double alpha =
              (0.4 + 0.6 * _controller.value).clamp(0, 1).toDouble();
          return CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(
              indicatorColor.withValues(alpha: alpha),
            ),
          );
        },
      ),
    );
  }
}
