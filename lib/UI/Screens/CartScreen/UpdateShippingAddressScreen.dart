import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:deal_bazaar/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:deal_bazaar/UI/Screens/SignUp_SignIn_Screens/SignIn_SignUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Core/services/local/local_db.dart';
import '../../shared/appbar.dart';
import '../../shared/textview.dart';
import '../BrandPage/BrandPage.dart';
import 'package:country_list_pick/country_list_pick.dart';

import '../NotificationScreen/NotificationScreen.dart';

class UpdateShippingAddress extends StatefulWidget {
  final String name;
  final String phon;
  final String email;
  final String address;
  final String address2;
  final String zip;
  final String id;
  UpdateShippingAddress(
      {required this.name,
      required this.id,
      required this.phon,
      required this.email,
      required this.address,
      required this.address2,
      required this.zip});

  @override
  State<UpdateShippingAddress> createState() => _UpdateShippingAddressState();
}

class _UpdateShippingAddressState extends State<UpdateShippingAddress> {
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _phonController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _address2Controller = TextEditingController();

  final TextEditingController _zipCodeController = TextEditingController();

  final TextEditingController _faceIdController = TextEditingController();
  bool isLogin = false;

  @override
  initState() {
    LocalDb.checkUserExists().then((value) {
      setState(() {
        print("this is");
        print(value);

        isLogin = value;
      });
    });
    setState(() {
      _fullNameController.text = widget.name;
      _address2Controller.text = widget.address2;
      _addressController.text = widget.address;
      _faceIdController.text = widget.zip;
      _phonController.text = widget.phon;
      _emailController.text = widget.email;
      _zipCodeController.text = widget.zip;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size? _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: defaultAppBar(context,
          leadingWidget: GestureDetector(
              onTap: () => Get.back(), child: Icon(Icons.clear)),
          titleWidget: TextView(
              text: 'Shipping Details',
              fontSize: 20,
              fontWeight: FontWeight.w600),
          menuWidget: GestureDetector(
            onTap: () {
              Get.to(() => NotificationScreen());
            },
            child: Icon(Icons.notifications, size: 24.sp),
          )),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: ListView(
          children: [
            SizedBox(height: 20.h),
            CustomTextFieldWithLeadingIcon(
              obsecure: false,
              controller: _fullNameController,
              leadingIcon: Icons.person,
              hint: 'Full Name',
              bcColor: yellowColor,
            ),
            SizedBox(height: 16.h),
            CustomTextFieldWithLeadingIcon(
              obsecure: false,
              controller: _phonController,
              hint: 'Phon number',
              leadingIcon: Icons.phone_android,
              bcColor: yellowColor,
            ),
            SizedBox(height: 16.h),
            CustomTextFieldWithLeadingIcon(
              obsecure: false,
              controller: _emailController,
              hint: 'Email address',
              leadingIcon: Icons.email,
              bcColor: yellowColor,
            ),
            SizedBox(height: 16.h),
            CustomTextFieldWithLeadingIcon(
              obsecure: false,
              controller: _addressController,
              hint: 'Shipping address',
              leadingIcon: Icons.location_on,
              bcColor: yellowColor,
            ),
            SizedBox(height: 16.h),
            CustomTextFieldWithLeadingIcon(
              obsecure: false,
              controller: _address2Controller,
              hint: 'Apartment No: (optional)',
              leadingIcon: Icons.location_on,
              bcColor: yellowColor,
            ),
            SizedBox(height: 16.h),
            Container(
              width: _size.width,
              decoration: BoxDecoration(
                color: Colors.yellow,
                border: Border.all(color: blackColor),
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: CountryListPick(
                onChanged: (value) {
                  print(value);
                },
                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                initialSelection: '+880',
              ),
            ),
            SizedBox(height: 16.h),
            CustomTextFieldWithLeadingIcon(
              obsecure: false,
              controller: _zipCodeController,
              hint: '12345',
              leadingIcon: Icons.maps_home_work_outlined,
              bcColor: yellowColor,
            ),
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: _size.width.w,
                height: 48.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: blackColor,
                ),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      print("button pressed");
                      LocalDb.checkUserExists().then((value) {
                        print("checked user");
                        if (value) {
                          print("exists");
                          LocalDb.getDbID().then((value) {
                            print(value);
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(value)
                                .update({
                              "emailAddress": _emailController.text,
                              "faceId": _faceIdController.text,
                              "addressLine": _addressController.text,
                              "addressLine2": _address2Controller.text,
                              "fullName": _fullNameController.text,
                              "phoneNumber": _phonController.text,
                              "zipCode": _zipCodeController.text
                            });
                            Get.off(HomeScreen());
                          });
                        } else {
                          print("not exists");
                          Get.to(SignInSignUpScreen());
                        }
                      });
                    },
                    child: Text(
                      'Update info',
                      style: GoogleFonts.lato(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}

class CustomTextFieldWithLeadingIcon extends StatelessWidget {
  final IconData leadingIcon;
  final String hint;
  final Color bcColor;
  final String? Function(String?)? validatorFunction;
  final TextEditingController controller;
  final bool obsecure;

  CustomTextFieldWithLeadingIcon(
      {required this.hint,
      required this.obsecure,
      required this.controller,
      this.validatorFunction,
      required this.leadingIcon,
      required this.bcColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 295.w,
      height: 45.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: bcColor,
        border: Border.all(color: blackColor),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Row(
        children: [
          Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(5.r),
              boxShadow: [
                BoxShadow(
                  color: greyColor.withOpacity(0.5),
                  blurRadius: 5,
                  spreadRadius: 0.1,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                leadingIcon,
                color: greyColor,
              ),
            ),
          ),
          SizedBox(width: 20.w),
          SizedBox(
            width: 200.w,
            child: TextFormField(
              obscureText: obsecure,
              controller: controller,
              validator: validatorFunction,
              cursorColor: blackColor,
              style: GoogleFonts.roboto(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: GoogleFonts.roboto(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: greyColor,
                ),
                border: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}
