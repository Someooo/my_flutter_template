import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_template/core/widgets/app_widgets/app_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showAppBar: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/test_test.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Center(
            child: GlassContainer(
              width: 200,
              height: 150,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Glass Container',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Align(
              alignment: Alignment.bottomLeft,
              // alignment: Alignment(0, 0.8),
              child: GlassNavigationBar(),
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
  const GlassNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double navWidth = screenWidth * 0.7;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
      ],
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