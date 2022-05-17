import 'package:deal_bazaar/Core/Constants/Assets.dart';
import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:deal_bazaar/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BrandPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
              Icon(
                Icons.notifications,
                size: 26.sp,
                color: Colors.transparent,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                // Get.to();
              },
              child: Image.asset(brandPageWebviewPic),
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 10.w),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Expanded(
            //         child: Align(
            //           alignment: Alignment.centerLeft,
            //           child: Icon(
            //             Icons.menu,
            //             size: 30.sp,
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         child: Image.asset(
            //           brandImageAddresses[1],
            //           scale: 4,
            //         ),
            //       ),
            //       Expanded(
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           children: [
            //             Icon(
            //               Icons.person_outline,
            //               size: 25.sp,
            //             ),
            //             SizedBox(width: 10.w),
            //             Icon(
            //               Icons.search,
            //               size: 25.sp,
            //             ),
            //             SizedBox(width: 10.w),
            //             Icon(
            //               Icons.shopping_bag_outlined,
            //               size: 25.sp,
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

class BottomNavGlobalHomeButtom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: GestureDetector(
        onTap: () {
          Get.offAll(() => HomeScreen());
        },
        child: Container(
          height: 40.h,
          width: 50.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: yellowColor,
          ),
          child: Center(
            child: Icon(
              Icons.home,
            ),
          ),
        ),
      ),
    );
  }
}
