import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:deal_bazaar/UI/Screens/CartScreen/CheckoutScreen.dart';
import 'package:deal_bazaar/UI/Screens/CartScreen/UpdateShippingAddressScreen.dart';
import 'package:deal_bazaar/UI/Screens/SignUp_SignIn_Screens/sign_up_viewmodel.dart';
import 'package:deal_bazaar/marka_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phonController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _address2Controller = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _faceIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SignUpViewModel>();
    return Scaffold(
      backgroundColor: yellowColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.h), // Set this height
        child: Container(
          width: 325.w,
          height: 100.h,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            color: yellowColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.r),
              bottomRight: Radius.circular(30.r),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 26.w,
                  height: 26.w,
                  padding: EdgeInsets.only(left: 7.w),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(5.r),
                    boxShadow: [
                      BoxShadow(
                        color: greyColor.withOpacity(0.5),
                        blurRadius: 5,
                        spreadRadius: 0.1,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                ),
              ),
              Text(
                'Sign Up',
                style: GoogleFonts.roboto(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.notifications,
                size: 30.sp,
                color: Colors.transparent,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            width: 1.sw,
            child: Column(
              children: [
                CustomTextFieldWithLeadingIcon(
                  obsecure: false,
                  controller: _fullNameController,
                  validatorFunction: (val) {
                    if (val!.isEmpty) {
                      return 'Please enter Your Full Name';
                    } else {
                      return null;
                    }
                  },
                  hint: 'Full Name',
                  leadingIcon: Icons.person,
                  bcColor: whiteColor,
                ),
                SizedBox(height: 16.h),
                CustomTextFieldWithLeadingIcon(
                  obsecure: false,
                  controller: _phonController,
                  validatorFunction: (val) {
                    if (val!.isEmpty) {
                      return 'Please enter Your Phon number';
                    } else {
                      return null;
                    }
                  },
                  hint: 'Phone Number',
                  leadingIcon: Icons.phone_android_sharp,
                  bcColor: whiteColor,
                ),
                SizedBox(height: 16.h),
                CustomTextFieldWithLeadingIcon(
                  obsecure: false,
                  controller: _emailController,
                  validatorFunction: (val) {
                    if (val!.isEmpty) {
                      return 'Please enter Your Email';
                    } else {
                      return null;
                    }
                  },
                  hint: 'Email',
                  leadingIcon: Icons.email,
                  bcColor: whiteColor,
                ),
                SizedBox(height: 16.h),
                CustomTextFieldWithLeadingIcon(
                  obsecure: false,
                  controller: _addressController,
                  validatorFunction: (val) {
                    if (val!.isEmpty) {
                      return 'Please enter Your Address';
                    } else {
                      return null;
                    }
                  },
                  hint: 'Address',
                  leadingIcon: Icons.location_on,
                  bcColor: whiteColor,
                ),
                SizedBox(height: 16.h),
                CustomTextFieldWithLeadingIcon(
                  obsecure: false,
                  controller: _address2Controller,
                  hint: 'Address 2 (Optional)',
                  leadingIcon: Icons.location_on,
                  bcColor: whiteColor,
                ),
                SizedBox(height: 16.h),
                CustomTextFieldWithLeadingIcon(
                  obsecure: false,
                  controller: _zipCodeController,
                  validatorFunction: (val) {
                    if (val!.isEmpty) {
                      return 'Please enter Your Zip Code';
                    } else {
                      return null;
                    }
                  },
                  hint: 'Zip Code',
                  leadingIcon: Icons.maps_home_work_outlined,
                  bcColor: whiteColor,
                ),
                SizedBox(height: 16.h),
                CustomTextFieldWithLeadingIcon(
                  obsecure: true,
                  controller: _passwordController,
                  validatorFunction: (val) {
                    if (val!.isEmpty) {
                      return 'Please enter Your Password';
                    } else {
                      return null;
                    }
                  },
                  hint: 'Password',
                  leadingIcon: Icons.lock,
                  bcColor: whiteColor,
                ),
                SizedBox(height: 16.h),
                CustomTextFieldWithLeadingIcon(
                  obsecure: true,
                  controller: _faceIdController,
                  hint: 'FaceID (Optional)',
                  leadingIcon: Icons.face_unlock_outlined,
                  bcColor: whiteColor,
                ),
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      vm.setFinalData(
                          fullName: _fullNameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          addressLine: _addressController.text,
                          phoneNumber: _phonController.text,
                          zipCode: _zipCodeController.text,
                          addressLine2: _address2Controller.text,
                          faceId: _faceIdController.text);
                    }
                  },
                  child: vm.loading
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: MarkaColors.gold,
                        ))
                      : Container(
                          width: 276.w,
                          height: 44.h,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            color: blackColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.arrow_forward,
                                size: 25.sp,
                                color: Colors.transparent,
                              ),
                              Text(
                                'SIGN UP',
                                style: GoogleFonts.lato(
                                  color: whiteColor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 25.sp,
                                color: whiteColor,
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
