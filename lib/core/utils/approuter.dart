import 'package:dio/dio.dart';
import 'package:doct_plant/core/utils/animations/transition_animation.dart';
import 'package:doct_plant/core/utils/api_service.dart';
import 'package:doct_plant/features/auth/login/view/login_view.dart';
import 'package:doct_plant/features/auth/login/view/view_model.dart/cubit/login_cubit.dart';
import 'package:doct_plant/features/auth/register/view/register_view.dart';
import 'package:doct_plant/features/auth/register/view_model.dart/cubit/register_cubit.dart';
import 'package:doct_plant/features/common_diseases/view/common_dis_view.dart';
import 'package:doct_plant/features/dr_plant_hub/view/dr_plant_hub_view.dart';
import 'package:doct_plant/features/home/view/home_view.dart';
import 'package:doct_plant/features/splash/splash_veiw.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final kDrHub = '/drhub';

  static final kHomeView = '/home';
  static final kLogin = '/login';
  static final kRegister = '/register';
  static final kComm = '/comm';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kHomeView,
        pageBuilder: (context, state) {
          return TransitionAnimation.zoomInAnimatition(
            state,
            route: const HomeView(),
          );
        },
      ),
      GoRoute(
        path: kLogin,
        pageBuilder: (context, state) {
          return TransitionAnimation.zoomInAnimatition(
            state,
            route: BlocProvider(
              create: (context) => LoginCubit(ApiService(Dio())),
              child: const LoginView(),
            ),
          );
        },
      ),
      GoRoute(
        path: kRegister,
        pageBuilder: (context, state) {
          return TransitionAnimation.zoomInAnimatition(
            state,
            route: BlocProvider(
              create: (context) => RegisterCubit(ApiService(Dio())),
              child: const RegisterView(),
            ),
          );
        },
      ),
      GoRoute(
        path: kDrHub,
        pageBuilder: (context, state) {
          return TransitionAnimation.zoomInAnimatition(
            state,
            route: BlocProvider(
              create: (context) => RegisterCubit(ApiService(Dio())),
              child: const DrPlantHubView(),
            ),
          );
        },
      ),
      GoRoute(
        path: kComm,
        pageBuilder: (context, state) {
          return TransitionAnimation.zoomInAnimatition(
            state,
            route: BlocProvider(
              create: (context) => RegisterCubit(ApiService(Dio())),
              child: const CommonDisView(),
            ),
          );
        },
      ),
    ],
  );
}
