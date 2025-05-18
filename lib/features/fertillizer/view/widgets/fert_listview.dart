import 'package:doct_plant/features/fertillizer/view/widgets/fert_tip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FertListview extends StatelessWidget {
  const FertListview({super.key});
  static const List<String> tips = [
    'Use Organic Fertilizers: They improve soil health and plant growth.',
    'Apply Fertilizers in the Morning: Helps plants absorb nutrients efficiently.',
    'Avoid Over-Fertilizing: Too much fertilizer can damage plant roots.',
    'Use Different Fertilizers for Different Plants: Each plant has unique nutrient needs.'
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: 5.h, left: 10.w),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: tips.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: FertTip(
              tip: tips[index],
            ),
          );
        },
      ),
    );
  }
}
