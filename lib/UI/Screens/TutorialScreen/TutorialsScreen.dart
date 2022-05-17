import 'package:deal_bazaar/Core/Constants/Assets.dart';
import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:deal_bazaar/UI/Screens/OnboardingScreens/OnboardingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TutorialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1.sw,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              tutorialImage,
              scale: 4,
            ),
            SizedBox(height: 36.h),
            Text(
              'How it Works?',
              style: GoogleFonts.roboto(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: 244.w,
              child: Text(
                'Learn complete work flow how the '
                'DEAL BAZAAR works in the '
                'onboarding.',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SizedBox(height: 60.h),
            GestureDetector(
              onTap: () {
                Get.offAll(() => OnBoardingScreens());
              },
              child: Container(
                width: 240.w,
                height: 44.h,
                decoration: BoxDecoration(
                  color: blackColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: Text(
                    'GET STARTED',
                    style: GoogleFonts.lato(
                      fontSize: 16.sp,
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
