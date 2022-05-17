import 'package:deal_bazaar/Core/Constants/Animations.dart';
import 'package:deal_bazaar/Core/Constants/Assets.dart';
import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:deal_bazaar/UI/Screens/BrandPage/BrandPage.dart';
import 'package:deal_bazaar/UI/Screens/BrandPage/OrderScreen.dart';
import 'package:deal_bazaar/UI/Screens/ChatScreen/ContactUsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class BrandPageProductWebviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BrandPageProductWebviewBottomNavigationBar(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.h), // Set this height
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
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
                Positioned(
                  bottom: -15.h,
                  child: CostBreakDownButtonWidget(),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                // SizedBox(height: 10.h),
                // CostBreakDownButtonWidget(),
                // SizedBox(height: 10.h),
                GestureDetector(
                  onTap: () {
                    Get.to(() => OrderScreen());
                  },
                  child: Image.asset(brandPageProductWebviewPic),
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
          ],
        ),
      ),
    );
  }
}

class BrandPageProductWebviewBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.h,
      width: 1.sw,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 46.w, height: 46.h),
                AddToWishListButtonWidget(),
              ],
            ),
          ),
          SizedBox(height: 14.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ChatScreenButtonWidget(),
                BottomNavGlobalHomeButtom(),
                AddToCartButtonWidget(),
              ],
            ),
          ),
          SizedBox(height: 38.h),
        ],
      ),
    );
  }
}

class ChatScreenButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ChatScreen());
      },
      child: Container(
        width: 46.w,
        height: 46.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: greyColor,
              blurRadius: 4,
              spreadRadius: 0.1,
            ),
          ],
        ),
        child: Lottie.asset(chatIcon),
      ),
    );
  }
}

class AddToCartButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        addToCartBottomSheet(context);
      },
      child: Container(
        width: 46.w,
        height: 46.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: greyColor,
              blurRadius: 4,
              spreadRadius: 0.1,
            ),
          ],
        ),
        child: Lottie.asset(cartEmpty),
      ),
    );
  }
}

Future<dynamic> addToCartBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.r),
    ),
    builder: (context) {
      return Container(
        width: 1.sw,
        height: 407.h,
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Container(
              width: 60.w,
              height: 4.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: blackColor,
              ),
            ),
            SizedBox(height: 35.h),
            Container(
              width: 209.w,
              height: 209.h,
              child: Lottie.asset(splashScreenAnimation),
            ),
            SizedBox(height: 10.h),
            Text(
              'ADDING TO CART',
              style: GoogleFonts.roboto(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: 5,
              ),
            ),
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Material(
                child: Container(
                  width: 240.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: blackColor,
                  ),
                  child: Center(
                    child: Text(
                      'Done',
                      style: GoogleFonts.lato(
                        fontSize: 16.sp,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}

class AddToWishListButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        addToWishListBottomSheet(context);
      },
      child: Container(
        width: 46.w,
        height: 46.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: greyColor,
              blurRadius: 4,
              spreadRadius: 0.1,
            ),
          ],
        ),
        child: Icon(
          Icons.favorite_border_outlined,
          size: 25.sp,
        ),
      ),
    );
  }
}

Future<dynamic> addToWishListBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.r),
    ),
    builder: (context) {
      return Container(
        width: 1.sw,
        height: 407.h,
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Container(
              width: 60.w,
              height: 4.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: blackColor,
              ),
            ),
            SizedBox(height: 35.h),
            Container(
              width: 209.w,
              height: 209.h,
              child: Lottie.asset(splashScreenAnimation),
            ),
            SizedBox(height: 10.h),
            Text(
              'ADDING TO WISHLIST',
              style: GoogleFonts.roboto(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: 5,
              ),
            ),
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Material(
                child: Container(
                  width: 240.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: blackColor,
                  ),
                  child: Center(
                    child: Text(
                      'Done',
                      style: GoogleFonts.lato(
                        fontSize: 16.sp,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}

class CostBreakDownButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        costBreakDownDialogBox(context);
      },
      child: Container(
        width: 284.w,
        height: 40.h,
        padding: EdgeInsets.only(left: 40.w, right: 10.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                color: greyColor.withOpacity(0.5),
                spreadRadius: 0.1,
                blurRadius: 5,
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'COST BREAKDOWN',
              style: GoogleFonts.roboto(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Lottie.asset(
                  tapEffect,
                  frameRate: FrameRate(60),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 30.sp,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<Object?> costBreakDownDialogBox(BuildContext context) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black45,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (BuildContext buildContext, Animation animation,
        Animation secondaryAnimation) {
      return Center(
        child: Container(
          width: 284.w,
          height: 345.h,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            children: [
              Material(
                child: Text(
                  'Slide down to see price breakdown',
                  style: GoogleFonts.roboto(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              RotatedBox(
                quarterTurns: 2,
                child: Lottie.asset(
                  SlideAnimation,
                  height: 114.h,
                  width: 114.w,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Material(
                  child: Container(
                    width: 240.w,
                    height: 44.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: blackColor,
                    ),
                    child: Center(
                      child: Text(
                        'Done',
                        style: GoogleFonts.lato(
                          fontSize: 16.sp,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
