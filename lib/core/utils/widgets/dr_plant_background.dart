import 'package:doct_plant/constants/assets.dart';
import 'package:flutter/material.dart';

class DrPlantBackground extends StatelessWidget {
  const DrPlantBackground(
      {super.key, required this.child, this.width, this.height});
  final Widget child;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: height ?? double.infinity,
      height: width ?? double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.assetsBackground),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
