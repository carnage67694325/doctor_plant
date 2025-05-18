import 'package:doct_plant/core/utils/animations/cricular_clip.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransitionAnimation {
  static CustomTransitionPage<dynamic> circularTransitionAnimation(
      GoRouterState state,
      {required Widget? route}) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: route!,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Use AnimatedBuilder to handle animation and transitions
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            final size = MediaQuery.of(context).size;
            final radius = size.width * animation.value;

            // If the animation is completed, return the child without clipping
            if (animation.isCompleted) {
              return child!;
            } else {
              return ClipPath(
                clipper: CircleRevealClipper(radius: radius),
                child: child,
              );
            }
          },
          child: child,
        );
      },
      transitionDuration:
          const Duration(milliseconds: 800), // Adjust the duration as needed
    );
  }

  static CustomTransitionPage<dynamic> slidingTransitionAnimations(
      GoRouterState state,
      {required Widget? route}) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: route!,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0); // Start off-screen to the left
        const end = Offset.zero; // End at the normal position
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration:
          const Duration(milliseconds: 300), // Adjust the duration as needed
    );
  }

  static CustomTransitionPage<dynamic> zoomInAnimatition(GoRouterState state,
      {required Widget? route}) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: route!,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.8; // Start scale factor (smaller than 1.0)
        const end = 1.0; // End scale factor (normal size)
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var scaleAnimation = animation.drive(tween);

        return ScaleTransition(
          scale: scaleAnimation,
          child: child,
        );
      },
      transitionDuration:
          const Duration(milliseconds: 650), // Adjust the duration as needed
    );
  }

  static CustomTransitionPage<dynamic> slidingFromBottomAnimation(
      GoRouterState state,
      {required Widget? route}) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: route!,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0); // Start off-screen from the bottom
        const end = Offset.zero; // End at the normal position
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration:
          const Duration(milliseconds: 300), // Adjust the duration as needed
    );
  }
}
