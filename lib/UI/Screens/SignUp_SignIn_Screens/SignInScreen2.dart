import 'package:deal_bazaar/Core/Constants/Assets.dart';
import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:deal_bazaar/UI/Screens/CartScreen/UpdateShippingAddressScreen.dart';
import 'package:deal_bazaar/UI/Screens/SignUp_SignIn_Screens/SendOTPScreen.dart';
import 'package:deal_bazaar/UI/Screens/SignUp_SignIn_Screens/SignUpScreen.dart';
import 'package:deal_bazaar/UI/Screens/SignUp_SignIn_Screens/otp_view_model.dart';
import 'package:deal_bazaar/UI/base_view/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen2 extends StatefulWidget {
  @override
  State<SignInScreen2> createState() => _SignInScreen2State();
}

class _SignInScreen2State extends State<SignInScreen2> {
  bool isLoading = false;
  bool isTerm = false;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("inside the verify phon number");
    print(isLoading);
    final viewModel = context.watch<OtpViewModel>();
    return isLoading
        ? CircularProgressIndicator()
        : Scaffold(
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
                SizedBox(height: 10.h),
                Image.asset(
                  dealBazarTitle,
                  scale: 2,
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      'Continue to Sign in',
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
                SizedBox(height: 10.h),
                /* Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: GestureDetector(
                //Put a function

                onTap: () {},
                child: Text(
                  'Forgot Password?',
                  style: GoogleFonts.roboto(
                    fontSize: 12.sp,
                    color: redColor,
                  ),
                ),
              ),
            ),
          ),*/
                SizedBox(height: 5.h),
                /* CustomTextFieldWithLeadingIcon(
            obsecure: true,
            controller: _passwordController,
            hint: 'Password',
            leadingIcon: Icons.lock,
            bcColor: whiteColor,
          ),*/
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 18.w,
                        height: 18.w,
                        margin: EdgeInsets.only(top: 5.h, left: 20.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: blackColor),
                          shape: BoxShape.circle,
                        ),
                        child: Checkbox(
                          activeColor: blackColor,
                          checkColor: blackColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          value: isTerm,
                          onChanged: (value) {
                            setState(() {});
                            isTerm = value!;
                          },
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Text(
                          'By logging In I agree with TERMS & Conditions',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                InkWell(
                  onTap: () {
                    print("pressed");
                    if (_phonController.text.isNotEmpty) {
                      final res = viewModel.verifyNumberLocally(
                          phoneNumber: _phonController.text);
                      if (res) {
                        setState(() {
                          isLoading = true;
                        });
                        log('Phone Number  Verified');
                        viewModel.callToFirebase(
                            phoneNumber: _phonController.text);
                        setState(() {
                          isLoading = false;
                        });
                      } else if (!res) {
                        log('Phone Number Not Verified');
                        Get.snackbar('Verification Failed',
                            'Provide Correct Country Code/Phone Number',
                            backgroundColor: MarkaColors.gold,
                            colorText: MarkaColors.white,
                            duration: const Duration(seconds: 10),
                            snackPosition: SnackPosition.BOTTOM);
                      }
                    } else {
                      Get.snackbar('Error', 'Provide your mobile number',
                          backgroundColor: MarkaColors.gold,
                          colorText: MarkaColors.white,
                          duration: const Duration(seconds: 10),
                          snackPosition: SnackPosition.BOTTOM);
                    }
                  },
                  child: SignInCustomButtonPhon(
                    title: 'SIGN IN',
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Text(
                        'Do not have an account yet?',
                        style: GoogleFonts.roboto(
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => SignUpScreen());
                        },
                        child: Text(
                          'SIGN UP',
                          style: GoogleFonts.lato(
                            letterSpacing: 2,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}

class SignInCustomButtonPhon extends StatelessWidget {
  final String title;

  SignInCustomButtonPhon({
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
