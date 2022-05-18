import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../shared/textview.dart';

class OnBoardingWidget extends StatelessWidget {
  final String? image;
  final String? title;
  final String? slogan;

  OnBoardingWidget(
      {required this.image, required this.title, required this.slogan});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 23.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(image!),
          TextView(
            text: title ?? '',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 10.h),
          TextView(
            text: slogan ?? '',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
