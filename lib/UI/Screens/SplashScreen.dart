import 'package:deal_bazaar/Core/Constants/Animations.dart';
import 'package:deal_bazaar/Core/Constants/Assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Lottie.asset(splashScreenAnimation),
              Column(
                children: [
                  SizedBox(height: 80.h),
                  Image.asset(
                    splashScreenTitle,
                    scale: 4,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
