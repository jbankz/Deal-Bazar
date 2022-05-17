import 'package:deal_bazaar/Core/Constants/Assets.dart';
import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../BrandPage/BrandPage.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavGlobalHomeButtom(),
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
                  'Notifications',
                  style: GoogleFonts.roboto(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
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
        body: Center(
            child: Container(
          child: Text("No notifications"),
        )) /*Container(
        width: 1.sw,
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    child: NotificationCardWidget(),
                  );
                },
              ),
            ),
          ],
        ),
      ),*/
        );
  }
}

class NotificationCardWidget extends StatelessWidget {
  const NotificationCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 309.w,
      height: 53.h,
      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: greyColor.withOpacity(0.5),
            blurRadius: 5,
            spreadRadius: 0.1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(notificationImage),
          SizedBox(width: 10.w),
          SizedBox(
            width: 180.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'New Popular Items ahead',
                  style: GoogleFonts.roboto(
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  'Checkout top new products here',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                    fontSize: 13.sp,
                    color: greyColor,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 10.sp,
                color: greyColor,
              ),
              SizedBox(width: 3.w),
              Text(
                '10:55 PM',
                style: GoogleFonts.roboto(
                  fontSize: 9.sp,
                  color: greyColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
