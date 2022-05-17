import 'package:deal_bazaar/Core/Constants/Assets.dart';
import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:deal_bazaar/UI/Screens/SignUp_SignIn_Screens/SignUpScreen.dart';
import 'package:deal_bazaar/UI/Screens/SignUp_SignIn_Screens/SignInScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInSignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yellowColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'Almost one step away',
            style: GoogleFonts.roboto(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 13.h),
          Image.asset(SignUpSignInWelcomePagePic),
          SizedBox(height: 50.h),
          SignInCustomButton(
            title: 'SIGN UP',
            routeTo: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpScreen()),
              );
            },
          ),
          SizedBox(height: 20.h),
          SignInCustomButton(
            title: 'SIGN IN',
            routeTo: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SignInCustomButton extends StatelessWidget {
  final String title;
  final Function routeTo;
  SignInCustomButton({
    required this.title,
    required this.routeTo,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        routeTo();
      },
      child: Container(
        width: 276.w,
        height: 44.h,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: blackColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.arrow_forward,
              color: Colors.transparent,
            ),
            Text(
              title,
              style: GoogleFonts.lato(
                color: whiteColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: whiteColor,
              size: 25.sp,
            ),
          ],
        ),
      ),
    );
  }
}
