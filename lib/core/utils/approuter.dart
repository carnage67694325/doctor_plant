import 'package:doct_plant/core/utils/animations/transition_animation.dart';
import 'package:doct_plant/features/splash/splash_veiw.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final kHomeView = '/home';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      // GoRoute(
      //   path: kHomeView,
      //   pageBuilder: (context, state) {
      //     return TransitionAnimation.zoomInAnimatition(
      //       state,
      //       route: const HomeView(),
      //     );
      //   },
      // ),
    ],
  );
}
