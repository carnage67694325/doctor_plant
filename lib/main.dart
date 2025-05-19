import 'package:doct_plant/core/Preferences/prefs_handler.dart';
import 'package:doct_plant/core/utils/appcolor.dart';
import 'package:doct_plant/core/utils/approuter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  await PrefasHandelr.init();

  await dotenv.load(fileName: "lib/.env");
  runApp(const DoctorPlant());
}

class DoctorPlant extends StatelessWidget {
  const DoctorPlant({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 915),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.primaryColor,
            appBarTheme: AppBarTheme(
              color: AppColors.primaryColor,
            ),
          ),
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
