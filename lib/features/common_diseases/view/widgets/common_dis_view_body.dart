import 'package:doct_plant/core/utils/widgets/dr_plant_background.dart';
import 'package:doct_plant/features/common_diseases/view/widgets/dis_listview.dart';
import 'package:flutter/material.dart';

class CommonDisViewBody extends StatelessWidget {
  const CommonDisViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DrPlantBackground(child: DisListView()),
    );
  }
}
