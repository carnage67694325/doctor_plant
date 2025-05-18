import 'package:doct_plant/features/dr_plant_hub/view/widgets/hub_tile.dart';
import 'package:flutter/material.dart';
import 'package:doct_plant/features/common_diseases/model/dis_model.dart';
import 'package:doct_plant/features/common_diseases/view/widgets/dis_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DisListView extends StatelessWidget {
  const DisListView({
    super.key,
  });

  static const List<DisModel> dis = [
    DisModel(
        desc: 'Fungal disease affecting leaves',
        image: 'https://dr-plant.vercel.app/leaf-blight.jpg',
        name: 'Leaf Blight'),
    DisModel(
        desc: 'White powder-like fungal infection.',
        image: 'https://dr-plant.vercel.app/powdery-mildew.webp',
        name: 'Powdery Mildew'),
    DisModel(
        desc: 'Gray mold affecting flowers and fruits.',
        image: 'https://dr-plant.vercel.app/Botrytis-Blight.jpg',
        name: 'Botrytis Blight'),
    DisModel(
        desc: 'Dark water-soaked spots on leaves.',
        image: 'https://dr-plant.vercel.app/bacterial-leaf-spot.webp',
        name: 'Bacterial Leaf Spot'),
    DisModel(
        desc: 'Fungal infection causing wilting and yellowing.',
        image: 'https://dr-plant.vercel.app/Fusarium-Wilt.jpg',
        name: 'Fusarium Wilt'),
    DisModel(
        desc: 'Orange or reddish-brown spots on leaves.',
        image: 'https://dr-plant.vercel.app/Rust.webp',
        name: 'Rust'),
    DisModel(
        desc: 'Dark lesions on leaves, stems, and fruits.',
        image: 'https://dr-plant.vercel.app/anthracnose.jpg',
        name: 'Anthracnose'),
    DisModel(
        desc: 'Mold growth on the underside of leaves.',
        image: 'https://dr-plant.vercel.app/Downy-Mildew.jpg',
        name: 'Downy Mildew'),
    DisModel(
        desc: 'Caused by overwatering and poor drainage.',
        image: 'https://dr-plant.vercel.app/Root-Rot.webp',
        name: 'Root Rot'),
    DisModel(
        desc: 'White powder-like fungal infection.',
        image: 'https://dr-plant.vercel.app/powdery-mildew.webp',
        name: 'Powdery Mildew'),
    // You can add more disease models here
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 230.r),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: dis.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: PlantDiseaseCard(
              dis: dis[index],
            ),
          );
        },
      ),
    );
  }
}
