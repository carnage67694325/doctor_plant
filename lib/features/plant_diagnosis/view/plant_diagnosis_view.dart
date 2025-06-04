import 'package:doct_plant/core/utils/functions/premision_handeler.dart';
import 'package:doct_plant/features/plant_diagnosis/view/widgets/plant_diagnosis_view_body.dart';
import 'package:flutter/material.dart';

class PlantDiagnosisView extends StatefulWidget {
  const PlantDiagnosisView({super.key});

  @override
  State<PlantDiagnosisView> createState() => _PlantDiagnosisViewState();
}

class _PlantDiagnosisViewState extends State<PlantDiagnosisView> {
  @override
  void initState() {
    requestStoragePermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const PlantDiagnosisViewBody();
  }
}
