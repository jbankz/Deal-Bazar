import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deal_bazaar/Core/Constants/Assets.dart';
import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:deal_bazaar/UI/Screens/SignUp_SignIn_Screens/SignIn3.dart';
import 'package:deal_bazaar/UI/Screens/SignUp_SignIn_Screens/sign_up_viewmodel.dart';
import 'package:deal_bazaar/UI/base_view/base_view.dart';
import 'package:deal_bazaar/UI/services/auth_service.dart';
import 'package:deal_bazaar/UI/Screens/SignUp_SignIn_Screens/SignInScreen2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  AuthService authService = new AuthService();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SignUpViewModel>();
    return Scaffold(
      backgroundColor: yellowColor,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
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
                  Text(
                    'Almost one step away',
                    style: GoogleFonts.roboto(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 13.h),
                  Image.asset(SignUpScreen1Pic, scale: 2.5),
                  SizedBox(height: 50.h),
                  SizedBox(
                    width: 276.w,
                    height: 44.h,
                    child: SignInButton(
                      Buttons.Google,
                      text: 'LOG IN WITH GMAIL',
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await authService
                            .signInWithGoogle(context)
                            .then((result) async {
                          print("back from google sign in");
                          setState(() {
                            isLoading = false;
                          });
                          if (result != null) {
                            print("this is email");
                            print(result.user!.email);
                            FirebaseFirestore.instance
                                .collection("users")
                                .where("emailAddress",
                                    isEqualTo: result.user!.email)
                                .get()
                                .then((value) {
                              if (value.docs.length > 0) {
                                vm.setFinalDataFromGoogle(
                                    id: value.docs[0].id,
                                    fullName:
                                        result.user!.displayName.toString(),
                                    email: result.user!.email.toString(),
                                    password: "",
                                    addressLine: "",
                                    phoneNumber: "",
                                    zipCode: "",
                                    addressLine2: "",
                                    faceId: "");
                              } else {
                                vm.setFinalDataFromGoogle(
                                    id: result.user!.uid,
                                    fullName:
                                        result.user!.displayName.toString(),
                                    email: result.user!.email.toString(),
                                    password: "",
                                    addressLine: "",
                                    phoneNumber: "",
                                    zipCode: "",
                                    addressLine2: "",
                                    faceId: "");
                              }
                            });
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: 276.w,
                    height: 44.h,
                    child: SignInButton(
                      Buttons.Hotmail,
                      text: 'LOG IN WITH Email',
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      onPressed: () {
                        Get.to(SignInScreen3());
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: blackColor,
                          indent: 20.w,
                          endIndent: 10.w,
                          thickness: 1,
                        ),
                      ),
                      Text(
                        'OR',
                        style: GoogleFonts.roboto(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: blackColor,
                          indent: 10.w,
                          endIndent: 20.w,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => SignInScreen2());
                    },
                    child: Container(
                      width: 276.w,
                      height: 44.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        color: blackColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.phone_android_sharp,
                            color: whiteColor,
                          ),
                          SizedBox(width: 20.w),
                          Text(
                            'LOG IN WITH PHONE',
                            style: GoogleFonts.lato(
                              color: whiteColor,
                              fontSize: 15.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
