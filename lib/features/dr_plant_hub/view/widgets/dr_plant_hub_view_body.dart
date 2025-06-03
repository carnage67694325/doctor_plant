import 'package:doct_plant/core/utils/approuter.dart';
import 'package:doct_plant/core/utils/widgets/dr_plant_background.dart';
import 'package:doct_plant/features/dr_plant_hub/view/widgets/hub_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DrPlantHubViewBody extends StatelessWidget {
  const DrPlantHubViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.dehaze,
          size: 35.h,
        ),
        actions: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).push(AppRouter.kChatbot);
            },
            icon: Icon(Icons.smart_toy, size: 35.h),
          )
        ],
      ),
      body: DrPlantBackground(
          child: SingleChildScrollView(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 220.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HubTile(
                      onTap: () {
                        GoRouter.of(context).push(AppRouter.kPlantDiag);
                      },
                      text: "Upload Image",
                      icon: Icons.cloud_upload,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    HubTile(
                      onTap: () {
                        GoRouter.of(context).push(AppRouter.kComm);
                      },
                      text: "Common Diseases",
                      icon: Icons.travel_explore,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HubTile(
                      onTap: () {},
                      text: "Report a problem",
                      icon: Icons.warning,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    HubTile(
                      onTap: () {
                        GoRouter.of(context).push(AppRouter.kFert);
                      },
                      text: "Fertilizers",
                      icon: Icons.lightbulb_circle_rounded,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
