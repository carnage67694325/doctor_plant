import 'package:flutter/material.dart';

class CircleRevealClipper extends CustomClipper<Path> {
  final double radius;

  CircleRevealClipper({required this.radius});

  @override
  Path getClip(Size size) {
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    path.addOval(Rect.fromCircle(center: center, radius: radius));
    return path;
  }

  @override
  bool shouldReclip(CircleRevealClipper oldClipper) {
    return radius != oldClipper.radius;
  }
}
