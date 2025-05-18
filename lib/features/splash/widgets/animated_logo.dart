import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FlickeringAnimatedLogo extends StatefulWidget {
  const FlickeringAnimatedLogo({
    super.key,
    required this.logo,
  });
  final Widget logo;
  @override
  State<FlickeringAnimatedLogo> createState() => _FlickeringAnimatedLogoState();
}

class _FlickeringAnimatedLogoState extends State<FlickeringAnimatedLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _flickerController;
  late Animation<double> _flickerAnimation;

  @override
  void initState() {
    super.initState();

    // Setup flicker animation controller
    _flickerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: false);

    // Create a sequence of opacity values for flickering effect
    _flickerAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.4), weight: 5),
      TweenSequenceItem(tween: Tween(begin: 0.4, end: 1.0), weight: 5),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.7), weight: 5),
      TweenSequenceItem(tween: Tween(begin: 0.7, end: 1.0), weight: 5),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 50),
    ]).animate(_flickerController);
  }

  @override
  void dispose() {
    _flickerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _flickerController,
      builder: (context, _) {
        return FadeTransition(
          opacity: _flickerAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              widget.logo,
              SizedBox(
                height: 4.h,
              ),
            ],
          ),
        );
      },
    );
  }
}
