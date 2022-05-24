import 'package:deal_bazaar/Core/Constants/Assets.dart';
import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:deal_bazaar/Core/Constants/logger.dart';
import 'package:deal_bazaar/Core/services/authorization/auth_service.dart';
import 'package:deal_bazaar/Core/utils/validators.dart';
import 'package:deal_bazaar/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:deal_bazaar/UI/Screens/SignUp_SignIn_Screens/SignUpScreen.dart';
import 'package:deal_bazaar/UI/Screens/SignUp_SignIn_Screens/sign_in_viewmodel.dart';
import 'package:deal_bazaar/UI/base_view/base_view.dart';
import 'package:deal_bazaar/UI/shared/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/custom_textview.dart';

class SignInScreen3 extends StatefulWidget {
  @override
  State<SignInScreen3> createState() => _SignInScreen3State();
}

class _SignInScreen3State extends State<SignInScreen3> {
  bool isLoading = false;
  bool isTerm = false;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  SignInViewModel? signInViewModel;

  @override
  void initState() {
    signInViewModel = Provider.of<SignInViewModel>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yellowColor,
      appBar: AppBar(
        backgroundColor: yellowColor,
        elevation: .0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Text(
                  'Welcome Back!',
                  style: GoogleFonts.roboto(
                    fontSize: 20.sp,
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
                  child: Text(
                    'Continue to Sign in',
                    style: GoogleFonts.roboto(
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                CustomTextFieldWithLeadingIcon(
                  obsecure: false,
                  controller: _emailController,
                  hint: 'Email',
                  leadingIcon: Icons.phone_android_sharp,
                  validatorFunction: Validators.validateEmail(),
                  bcColor: whiteColor,
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Forgot Password?',
                      style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        color: redColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                CustomTextFieldWithLeadingIcon(
                  obsecure: true,
                  controller: _passwordController,
                  hint: 'Password',
                  leadingIcon: Icons.lock,
                  bcColor: whiteColor,
                  validatorFunction: Validators.validatePlainPass(),
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
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
                      Expanded(
                        child: Text(
                          'By logging In I agree with TERMS & Conditions',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                Consumer<SignInViewModel>(
                  builder: (context, vm, child) {
                    return ButtonWidget(
                        btnText: 'Sign in',
                        isLoading: vm.loading,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            signInViewModel?.signInUser(
                                email: _emailController.text,
                                password: _passwordController.text);
                          }
                        });
                  },
                ),
                SizedBox(height: 20.h),
                Row(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
