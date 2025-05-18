import 'package:doct_plant/constants/assets.dart';
import 'package:doct_plant/core/utils/appcolor.dart';
import 'package:doct_plant/features/home/view/widgets/custom_elvated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.assetsBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomElvatedButton(
              onPressed: () {},
              child: const Text(
                'Login',
                style: TextStyle(
                  fontSize: 45,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 35.h,
            ),
            CustomElvatedButton(
              onPressed: () {},
              backgroundColor: AppColors.signUpButtoColor,
              child: const Text('Register',
                  style: TextStyle(
                    fontSize: 45,
                    color: Colors.white,
                  )),
            ),
            SizedBox(
              height: 45.h,
            ),
          ],
        ),
      ),
    );
  }
}
