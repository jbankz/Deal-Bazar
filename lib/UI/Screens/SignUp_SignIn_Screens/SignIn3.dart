import 'package:deal_bazaar/Core/Constants/Assets.dart';
import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:deal_bazaar/Core/services/authorization/auth_service.dart';
import 'package:deal_bazaar/UI/Screens/CartScreen/UpdateShippingAddressScreen.dart';
import 'package:deal_bazaar/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:deal_bazaar/UI/Screens/SignUp_SignIn_Screens/SendOTPScreen.dart';
import 'package:deal_bazaar/UI/Screens/SignUp_SignIn_Screens/SignUpScreen.dart';
import 'package:deal_bazaar/UI/Screens/SignUp_SignIn_Screens/otp_view_model.dart';
import 'package:deal_bazaar/UI/Screens/SignUp_SignIn_Screens/sign_in_viewmodel.dart';
import 'package:deal_bazaar/UI/base_view/base_view.dart';
import 'package:deal_bazaar/UI/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen3 extends StatefulWidget {
  @override
  State<SignInScreen3> createState() => _SignInScreen3State();
}

class _SignInScreen3State extends State<SignInScreen3> {
  bool isLoading = false;
  bool isTerm = false;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SignInViewModel>();
    return Scaffold(
      backgroundColor: yellowColor,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
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
                  controller: _emailController,
                  hint: 'Email',
                  leadingIcon: Icons.phone_android_sharp,
                  bcColor: whiteColor,
                ),
                SizedBox(height: 10.h),
                Align(
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
                ),
                SizedBox(height: 5.h),
                CustomTextFieldWithLeadingIcon(
                  obsecure: true,
                  controller: _passwordController,
                  hint: 'Password',
                  leadingIcon: Icons.lock,
                  bcColor: whiteColor,
                ),
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
                    setState(() {
                      isLoading = true;
                    });
                    print("pressed");
                    if (_emailController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty) {
                      AuthService authService = AuthService();
                      vm.signInUser(
                          email: _emailController.text,
                          password: _passwordController.text);
                    } else {
                      setState(() {
                        isLoading = false;
                      });
                      Get.snackbar('Error', 'Provide your credientials',
                          backgroundColor: MarkaColors.gold,
                          colorText: MarkaColors.white,
                          duration: const Duration(seconds: 10),
                          snackPosition: SnackPosition.BOTTOM);
                    }
                  },
                  child: SignInCustomButton(
                    title: 'SIGN IN',
                    routeTo: () {
                      setState(() {
                        isLoading = true;
                      });
                      print("pressed");
                      if (_emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty) {
                        AuthService authService = AuthService();
                        authService
                            .signInUser(
                                email: _emailController.text,
                                password: _passwordController.text)
                            .then((value) {
                          if (value.status == 'failed') {
                            setState(() {
                              isLoading = false;
                            });
                          } else {
                            Get.to(HomeScreen());
                          }
                        });
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                        Get.snackbar('Error', 'Provide your credientials',
                            backgroundColor: MarkaColors.gold,
                            colorText: MarkaColors.white,
                            duration: const Duration(seconds: 10),
                            snackPosition: SnackPosition.BOTTOM);
                      }
                    },
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
