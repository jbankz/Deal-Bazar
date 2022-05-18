import 'package:deal_bazaar/Core/Constants/Animations.dart';
import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:deal_bazaar/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:deal_bazaar/UI/shared/textview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'widgets/info_widget.dart';

class OnboardingFinalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(23.w),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OnBoardingWidget(
                      image: onboardingGetStarted,
                      title: 'YOU ARE ALL DONE',
                      slogan: 'Lorem ipsum dolor sit amet, consectetur '
                          'adipiscing elit. Duis magna justo, '
                          'scelerisque et euismod',
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () => Get.offAll(() => HomeScreen()),
                  child: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: yellowColor,
                    child: Icon(
                      Icons.arrow_forward,
                      color: blackColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
