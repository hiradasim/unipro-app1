import 'dart:ui';
import 'package:flutter/material.dart';

const appGradient = LinearGradient(
  colors: [Color(0xFFC4B5FD), Color(0xFFFF2D95), Color(0xFF008CFF)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

Widget glassCard({
  required Widget child,
  BorderRadius? radius,
  EdgeInsets? padding,
}) {
  final borderRadius = radius ?? BorderRadius.circular(12);
  return ClipRRect(
    borderRadius: borderRadius,
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        padding: padding ?? const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.4),
              Colors.white.withOpacity(0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: borderRadius,
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: child,
      ),
    ),
  );
}
