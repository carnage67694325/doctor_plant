import 'package:dio/dio.dart';
import 'package:doct_plant/core/utils/animations/transition_animation.dart';
import 'package:doct_plant/core/utils/api_service.dart';
import 'package:doct_plant/features/auth/login/view/login_view.dart';
import 'package:doct_plant/features/auth/login/view/view_model.dart/cubit/login_cubit.dart';
import 'package:doct_plant/features/auth/register/view/register_view.dart';
import 'package:doct_plant/features/auth/register/view_model.dart/cubit/register_cubit.dart';
import 'package:doct_plant/features/chat_bot/view/chat_bot_view.dart';
import 'package:doct_plant/features/chat_bot/view/view_model/cubit/chatbot_cubit.dart';
import 'package:doct_plant/features/common_diseases/view/common_dis_view.dart';
import 'package:doct_plant/features/dr_plant_hub/view/dr_plant_hub_view.dart';
import 'package:doct_plant/features/feedback/view/feedback_view.dart';
import 'package:doct_plant/features/fertillizer/view/fertillizer_view.dart';
import 'package:doct_plant/features/home/view/home_view.dart';
import 'package:doct_plant/features/plant_diagnosis/view/plant_diagnosis_view.dart';
import 'package:doct_plant/features/plant_diagnosis/view/view_model/image_analysis/image_analysis_cubit.dart';
import 'package:doct_plant/features/plant_diagnosis/view/view_model/upload_image_cubit/plant_diagonsis_cubit.dart';
import 'package:doct_plant/features/report_problem/view/report_problem_view.dart';
import 'package:doct_plant/features/report_problem/view/view_model/report_problem/report_problem_cubit.dart';
import 'package:doct_plant/features/splash/splash_veiw.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final kDrHub = '/drhub';

  static final kHomeView = '/home';
  static final kLogin = '/login';
  static final kRegister = '/register';
  static final kComm = '/comm';
  static final kFert = '/fert';
  static final kPlantDiag = '/PlantDiag';
  static final kChatbot = '/chatbot';
  static final kReportProblem = '/reportProblem';
  static final kFeedback = '/feedback';

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
      GoRoute(
        path: kFert,
        pageBuilder: (context, state) {
          return TransitionAnimation.zoomInAnimatition(
            state,
            route: BlocProvider(
              create: (context) => RegisterCubit(ApiService(Dio())),
              child: const FertillizerView(),
            ),
          );
        },
      ),
      GoRoute(
        path: kPlantDiag,
        pageBuilder: (context, state) {
          return TransitionAnimation.zoomInAnimatition(
            state,
            route: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => UpLoadImageCubit(ApiService(Dio())),
                ),
                BlocProvider(
                  create: (context) => ImageAnalysisCubit(ApiService(Dio())),
                ),
              ],
              child: const PlantDiagnosisView(),
            ),
          );
        },
      ),
      GoRoute(
        path: kChatbot,
        pageBuilder: (context, state) {
          return TransitionAnimation.zoomInAnimatition(
            state,
            route: BlocProvider(
              create: (context) => ChatbotCubit(dio: Dio()),
              child: const ChatBotView(),
            ),
          );
        },
      ),
      GoRoute(
        path: kReportProblem,
        pageBuilder: (context, state) {
          return TransitionAnimation.zoomInAnimatition(
            state,
            route: BlocProvider(
              create: (context) => ReportProblemCubit(ApiService(Dio())),
              child: const ReportProblemView(),
            ),
          );
        },
      ),
      GoRoute(
        path: kFeedback,
        pageBuilder: (context, state) {
          return TransitionAnimation.zoomInAnimatition(
            state,
            route: BlocProvider(
              create: (context) => ReportProblemCubit(ApiService(Dio())),
              child: const FeedbackView(),
            ),
          );
        },
      ),
    ],
  );
}
