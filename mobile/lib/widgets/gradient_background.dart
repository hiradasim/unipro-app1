import 'package:flutter/material.dart';

/// A simple wrapper that paints a pink to purple gradient background.
class GradientBackground extends StatelessWidget {
  final Widget child;
  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xfff66bff), Color(0xff7f5fff)],
        ),
      ),
      child: child,
    );
  }
}
