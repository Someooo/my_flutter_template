import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_template/core/widgets/app_widgets/app_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const double _overlayWidth = 120;
  static const double _overlayHeight = 80;
  static const double _navigationBottomPadding = 32;
  static const double _navigationHeight = 70;

  bool _showOverlay = false;
  double? _overlayLeft;

  void _showOverlayAt(double desiredLeft, double minLeft, double maxLeft) {
    setState(() {
      _overlayLeft = desiredLeft.clamp(minLeft, maxLeft);
      _showOverlay = true;
    });
  }

  void _hideOverlay() {
    if (!_showOverlay) return;
    setState(() {
      _showOverlay = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double navigationWidth = screenWidth * 0.7;
    final double navStart = 24;
    final double navEnd = navStart + navigationWidth;
    final double initialOverlayLeft = navStart + (navigationWidth - _overlayWidth) / 2;
    final double overlayMinLeft = navStart;
    final double overlayMaxLeft = navEnd - _overlayWidth;
    final double overlayBottom = _navigationBottomPadding + (_navigationHeight - _overlayHeight) / 2;

    final double overlayLeft = _overlayLeft ?? initialOverlayLeft;

    return AppScaffold(
      showAppBar: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/test_test.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeOut,
            left: overlayLeft,
            bottom: overlayBottom,
            child: IgnorePointer(
              ignoring: !_showOverlay,
              child: AnimatedOpacity(
                opacity: _showOverlay ? 1 : 0,
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeOut,
                child: GlassActionWidget(
                  width: _overlayWidth,
                  height: _overlayHeight,
                ),
              ),
            ),
          ),
          Positioned(
            left: navStart,
            bottom: 32,
            child: GlassNavigationBar(
              width: navigationWidth,
              onPanDown: (details) {
                final desiredLeft = navStart + details.localPosition.dx - (_overlayWidth / 2);
                _showOverlayAt(desiredLeft, overlayMinLeft, overlayMaxLeft);
              },
              onPanUpdate: (details) {
                final desiredLeft = navStart + details.localPosition.dx - (_overlayWidth / 2);
                _showOverlayAt(desiredLeft, overlayMinLeft, overlayMaxLeft);
              },
              onPanEnd: (_) => _hideOverlay(),
              onPanCancel: _hideOverlay,
            ),
          ),
        ],
      ),
    );
  }
}

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;

  const GlassContainer({super.key, required this.width, required this.height, required this.child});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              width: 1.5,
              color: Colors.white.withValues(alpha: 0.3)
              ),
        ),
          child: child,
        ),
      
      ),
      );
  }
}

class GlassNavigationBar extends StatelessWidget {
  final double? width;
  final GestureDragDownCallback? onPanDown;
  final GestureDragUpdateCallback? onPanUpdate;
  final GestureDragEndCallback? onPanEnd;
  final VoidCallback? onPanCancel;
  const GlassNavigationBar({
    super.key,
    this.width,
    this.onPanDown,
    this.onPanUpdate,
    this.onPanEnd,
    this.onPanCancel,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double navWidth = width ?? screenWidth * 0.7;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanDown: onPanDown,
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      onPanCancel: onPanCancel,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GlassContainer(
            width: navWidth,
            height: 70,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(Icons.home_rounded, color: Colors.white, size: 28),
                  Icon(Icons.search_rounded, color: Colors.white, size: 28),
                  Icon(Icons.person_rounded, color: Colors.white, size: 28),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          const GlassCircleButton(),
        ],
      ),
    );
  }
}

class GlassActionWidget extends StatelessWidget {
  final double width;
  final double height;

  const GlassActionWidget({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(26),
              border: Border.all(
                width: 1.4,
                color: Colors.white.withValues(alpha: 0.28),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.12),
                  blurRadius: 12,
                  spreadRadius: 1,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GlassCircleButton extends StatelessWidget {
  const GlassCircleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.2),
            border: Border.all(
              width: 1.5,
              color: Colors.white.withValues(alpha: 0.3),
            ),
          ),
          child: const Icon(
            Icons.star_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}