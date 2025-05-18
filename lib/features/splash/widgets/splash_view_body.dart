import 'package:doct_plant/constants/assets.dart';
import 'package:doct_plant/core/Preferences/prefs_handler.dart';
import 'package:doct_plant/core/utils/approuter.dart';
import 'package:doct_plant/features/splash/widgets/animated_logo.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;
  @override
  void initState() {
    super.initState();
    initiFlickerAnimation();
    transitionFromSplash();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FlickeringAnimatedLogo(
      logo: Image.asset(Assets.assetsLogo),
    ));
  }

  void initiFlickerAnimation() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    slidingAnimation =
        Tween<Offset>(begin: const Offset(0, .25), end: Offset.zero)
            .animate(animationController);
    animationController.forward();
  }

  void transitionFromSplash() {
    Future.delayed(const Duration(milliseconds: 2200), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          PrefasHandelr.checkAuthToken(context);
        }
      });
    });
  }
}
