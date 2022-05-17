import 'package:deal_bazaar/Core/Constants/Animations.dart';
import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:deal_bazaar/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class OnboardingFinalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              onboardingGetStarted,
              animate: true,
              frameRate: FrameRate(60),
            ),
            Text(
              'YOU ARE ALL DONE',
              style: GoogleFonts.roboto(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: 300.w,
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur '
                'adipiscing elit. Duis magna justo, '
                'scelerisque et euismod',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: 16.sp,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Lottie.asset(
              SlideAnimation,
              height: 60.h,
              width: 60.w,
            ),
            SizedBox(height: 10.h),
            GestureDetector(
              onTap: () {
                Get.to(() => HomeScreen());
              },
              child: Container(
                width: 240.w,
                height: 50.h,
                decoration: BoxDecoration(
                  color: blackColor,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: SlidingUpPanel(
                  onPanelSlide: (position) {
                    Get.to(() => HomeScreen());
                  },
                  panel: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: yellowColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_upward,
                            size: 30.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'SLIDE UP TO START',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
