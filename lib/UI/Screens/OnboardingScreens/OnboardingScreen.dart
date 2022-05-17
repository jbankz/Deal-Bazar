import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:deal_bazaar/UI/Screens/OnboardingScreens/OnBoardingPage2.dart';
import 'package:deal_bazaar/UI/Screens/OnboardingScreens/OnBoardingPage3.dart';
import 'package:deal_bazaar/UI/Screens/OnboardingScreens/OnBoardingPage4.dart';
import 'package:deal_bazaar/UI/Screens/OnboardingScreens/OnBoardingPage5.dart';
import 'package:deal_bazaar/UI/Screens/OnboardingScreens/OnboardingFinalScreen.dart';
import 'package:deal_bazaar/UI/Screens/OnboardingScreens/OnboardingPage1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingScreens extends StatelessWidget {
  List<Widget> getPages() {
    return [
      OnBoardingScreen1(),
      OnBoardingScreen2(),
      OnBoardingScreen3(),
      OnBoardingScreen4(),
      OnBoardingScreen5(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1.sh,
        width: 1.sw,
        child: Column(
          children: [
            Expanded(
              child: IntroductionScreen(
                scrollPhysics: ScrollPhysics(parent: ClampingScrollPhysics()),
                controlsPadding: EdgeInsets.only(bottom: 10.h),
                rawPages: getPages(),
                dotsDecorator: DotsDecorator(
                  size: Size(10.w, 6.h),
                  activeSize: Size(20.w, 6.h),
                  color: yellowColor.withOpacity(0.4),
                  activeColor: yellowColor,
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                ),
                next: Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: yellowColor,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_forward,
                      color: blackColor,
                    ),
                  ),
                ),
                // showSkipButton: true,
                // skip: SizedBox(
                //   width: 60.w,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         'SKIP',
                //         style: GoogleFonts.roboto(
                //           color: blackColor,
                //           fontSize: 16.sp,
                //         ),
                //       ),
                //       Icon(
                //         Icons.arrow_forward_ios,
                //         color: blackColor,
                //         size: 20.sp,
                //       ),
                //     ],
                //   ),
                // ),
                showBackButton: true,
                back: Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: yellowColor,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back,
                      color: blackColor,
                    ),
                  ),
                ),
                onDone: () {
                  Get.offAll(() => OnboardingFinalScreen());
                },
                done: Container(
                  height: 50.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: yellowColor,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_forward,
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.offAll(() => OnboardingFinalScreen());
              },
              child: SizedBox(
                width: 50.w,
                height: 20.h,
                child: FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SKIP',
                        style: GoogleFonts.roboto(
                          color: blackColor,
                          fontSize: 15.sp,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: blackColor,
                        size: 15.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
