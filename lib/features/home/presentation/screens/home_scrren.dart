import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_template/config/app_colors.dart';
import 'package:my_template/core/widgets/app_widgets/app_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const double _overlayWidth = 80;
  static const double _overlayHeight = 80;
  static const double _navigationBottomPadding = 32;
  static const double _navigationHeight = 70;
  static const double _overlayExtension = 10; // How much overlay extends outside nav bar

  bool _showOverlay = false;
  double? _overlayLeft;
  bool _showClassContainer = false;

  void _toggleClassContainer() {
    setState(() {
      _showClassContainer = !_showClassContainer;
    });
  }

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
    final double initialOverlayLeft =
        navStart + (navigationWidth - _overlayWidth) / 2;
    // Allow overlay to extend slightly outside navigation bar
    final double overlayMinLeft = navStart - _overlayExtension;
    final double overlayMaxLeft = navEnd - _overlayWidth + _overlayExtension;
    final double overlayBottom =
        _navigationBottomPadding + (_navigationHeight - _overlayHeight) / 2;

    final double overlayLeft = _overlayLeft ?? initialOverlayLeft;

    return AppScaffold(
        showAppBar: false,
        body: Stack(
          children: [
            // الخلفية
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

            // ClassContainer في الوسط
            Center(
              child: IgnorePointer(
                ignoring: !_showClassContainer,
                child: AnimatedOpacity(
                  opacity: _showClassContainer ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  child: AnimatedScale(
                    scale: _showClassContainer ? 1 : 0.8,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    child: const ClassContainer(),
                  ),
                ),
              ),
            ),

            // Navigation Bar
            Positioned(
              left: navStart,
              bottom: 32,
              child: GlassNavigationBar(
                width: navigationWidth,
                showOverlay: _showOverlay,
                overlayLeft: overlayLeft,
                overlayWidth: _overlayWidth,
                navStart: navStart,
                onPanDown: (details) {
                  final desiredLeft =
                      navStart + details.localPosition.dx - (_overlayWidth / 2);
                  _showOverlayAt(desiredLeft, overlayMinLeft, overlayMaxLeft);
                },
                onPanUpdate: (details) {
                  final desiredLeft =
                      navStart + details.localPosition.dx - (_overlayWidth / 2);
                  _showOverlayAt(desiredLeft, overlayMinLeft, overlayMaxLeft);
                },
                onPanEnd: (_) => _hideOverlay(),
                onPanCancel: _hideOverlay,
                onCircleButtonTap: _toggleClassContainer,
              ),
            ),

            // Overlay فوق الـ Navigation Bar
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
          ],
        ));
  }
}

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final bool enableBlur;

  const GlassContainer({
    super.key,
    required this.width,
    required this.height,
    required this.child,
    this.enableBlur = true,
  });

  @override
  Widget build(BuildContext context) {
    final Widget container = ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            width: 1.5,
            color: Colors.white.withValues(alpha: 0.3),
          ),
        ),
        child: child,
      ),
    );

    if (!enableBlur) {
      return container;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: container,
      ),
    );
  }
}

class GlassNavigationBar extends StatelessWidget {
  final double? width;
  final bool showOverlay;
  final double? overlayLeft;
  final double? overlayWidth;
  final double? navStart;
  final GestureDragDownCallback? onPanDown;
  final GestureDragUpdateCallback? onPanUpdate;
  final GestureDragEndCallback? onPanEnd;
  final VoidCallback? onPanCancel;
  final VoidCallback? onCircleButtonTap;
  const GlassNavigationBar({
    super.key,
    this.width,
    this.showOverlay = false,
    this.overlayLeft,
    this.overlayWidth,
    this.navStart,
    this.onPanDown,
    this.onPanUpdate,
    this.onPanEnd,
    this.onPanCancel,
    this.onCircleButtonTap,
  });

  int _getActiveIconIndex(double navWidth) {
    if (!showOverlay ||
        overlayLeft == null ||
        navStart == null ||
        overlayWidth == null) return -1;

    // Calculate the center of the overlay
    final double overlayCenter = overlayLeft! + (overlayWidth! / 2);

    // Calculate the position relative to the navigation bar
    final double relativePosition = overlayCenter - navStart!;

    // Divide navigation bar into 3 equal sections
    final double sectionWidth = navWidth / 3;

    // Determine which section the overlay center is in
    if (relativePosition < sectionWidth) {
      return 0; // First icon (home)
    } else if (relativePosition < sectionWidth * 2) {
      return 1; // Second icon (search)
    } else {
      return 2; // Third icon (person)
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double navWidth = width ?? screenWidth * 0.7;
    final Color primaryColor = AppLightColors.primaryColor;
    final int activeIconIndex = _getActiveIconIndex(navWidth);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onPanDown: onPanDown,
          onPanUpdate: onPanUpdate,
          onPanEnd: onPanEnd,
          onPanCancel: onPanCancel,
          child: GlassContainer(
            width: navWidth,
            height: 70,
            enableBlur: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.home_rounded,
                    color: activeIconIndex == 0 ? primaryColor : Colors.white,
                    size: 28,
                  ),
                  Icon(
                    Icons.search_rounded,
                    color: activeIconIndex == 1 ? primaryColor : Colors.white,
                    size: 28,
                  ),
                  Icon(
                    Icons.person_rounded,
                    color: activeIconIndex == 2 ? primaryColor : Colors.white,
                    size: 28,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        GlassCircleButton(onTap: onCircleButtonTap),
      ],
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
        borderRadius: BorderRadius.circular(100),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              width: 1.4,
              color: Colors.white.withValues(alpha: 0.15),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.08),
                blurRadius: 8,
                spreadRadius: 1,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GlassCircleButton extends StatelessWidget {
  final VoidCallback? onTap;

  const GlassCircleButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      onTapDown: (_) {}, // Consume the tap down event
      child: ClipOval(
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
      ),
    );
  }
}

class ClassContainer extends StatelessWidget {
  const ClassContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 180,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              width: 1.5,
              color: Colors.white.withValues(alpha: 0.3),
            ),
          ),
          child: const Center(
            child: Text(
              'Glass',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
