import 'package:deal_bazaar/Core/Constants/Animations.dart';
import 'package:deal_bazaar/Core/Constants/Assets.dart';
import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:deal_bazaar/UI/Screens/CartScreen/MyCartScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../BrandPage/BrandPage.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavGlobalHomeButtom(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.h), // Set this height
        child: Container(
          width: 325.w,
          height: 105.h,
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
              Image.asset(
                dealBazarTitle,
                scale: 2.5,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => MyCartScreen());
                },
                child: Icon(
                  Icons.shopping_cart,
                  size: 26.sp,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: 1.sw,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                chatBotAnimation,
                height: 110.h,
                width: 110.w,
              ),
              Text(
                'Agent available 24 hours',
                style: GoogleFonts.roboto(
                  fontSize: 24.sp,
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                width: 285.w,
                height: 110.h,
                padding: EdgeInsets.only(right: 20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: yellowColor,
                    width: 2,
                  ),
                ),
                child: InkWell(
                  onTap: () async {
                    const url = "https://wa.me/+923091433933?text=Hey!";

                    await launch(url);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.whatsapp,
                        size: 60,
                        color: Colors.green,
                      ),
                      // SizedBox(width: 10.w),
                      Text(
                        'WhatsApp',
                        style: GoogleFonts.roboto(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward,
                        size: 25.sp,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                width: 285.w,
                height: 110.h,
                padding: EdgeInsets.only(right: 20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: yellowColor,
                    width: 2,
                  ),
                ),
                child: InkWell(
                  onTap: () async {
                    await launch('sms:+923091433933?body=Hey! ');
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.sms,
                        size: 60,
                        color: Colors.lightBlue,
                      ),
                      // SizedBox(width: 10.w),
                      Text(
                        'Phone Message',
                        style: GoogleFonts.roboto(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward,
                        size: 25.sp,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                width: 285.w,
                height: 110.h,
                padding: EdgeInsets.only(right: 20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: yellowColor,
                    width: 2,
                  ),
                ),
                child: InkWell(
                  onTap: () async {
                    const url = "https://m.me/33mshafiq";

                    await launch(url);
                  },
                  child: Row(
                    children: [
                      Lottie.asset(WhatsAppAnimtion, height: 80),
                      // SizedBox(width: 10.w),
                      Text(
                        'Text us',
                        style: GoogleFonts.roboto(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward,
                        size: 25.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
