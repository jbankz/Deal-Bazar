import 'package:deal_bazaar/Core/Constants/Assets.dart';
import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:deal_bazaar/UI/Screens/CartScreen/UpdateShippingAddressScreen.dart';
import 'package:deal_bazaar/UI/Screens/SignUp_SignIn_Screens/OTPScreen.dart';
import 'package:deal_bazaar/UI/Screens/SignUp_SignIn_Screens/SignIn_SignUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SendOTPScreen extends StatelessWidget {
  final String phonNumber;
  final String varificationId;
  SendOTPScreen({required this.phonNumber, required this.varificationId});
  final TextEditingController _phonController = TextEditingController();

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
              child: Text(
                'Welcome Back!',
                style: GoogleFonts.roboto(
                  fontSize: 20.sp,
                ),
              ),
            ),
          ),
          Image.asset(
            SendOTPScreenPic,
          ),
          SizedBox(height: 10.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                'Receive OTP',
                style: GoogleFonts.roboto(
                  fontSize: 20.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          CustomTextFieldWithLeadingIcon(
            obsecure: false,
            controller: _phonController,
            hint: 'Phone Number',
            leadingIcon: Icons.phone_android_sharp,
            bcColor: whiteColor,
          ),
          SizedBox(height: 20.h),
          SignInCustomButton(
            title: 'GET OTP',
            routeTo: () {},
          ),
        ],
      ),
    );
  }
}
