import 'package:deal_bazaar/Core/Constants/Animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class OnBoardingScreen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            onBoarding3,
          ),
          SizedBox(height: 20.h),
          Text(
            'Lorem ipsum dolor sit amet',
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
        ],
      ),
    );
  }
}
