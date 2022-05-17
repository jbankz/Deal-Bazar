import 'package:deal_bazaar/Core/Constants/Assets.dart';
import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:deal_bazaar/UI/Screens/BrandPage/BrandPage.dart';
import 'package:deal_bazaar/UI/Screens/BrandPage/BrandPageProductWebviewScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../CartScreen/MyCartScreen.dart';

class OrderScreen extends StatefulWidget {
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavGlobalHomeButtom(),
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
                  child: Container(
                    width: 284.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        BoxShadow(
                          color: greyColor.withOpacity(0.5),
                          spreadRadius: 0.1,
                          blurRadius: 5,
                          offset: Offset(0, 5),
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Flat Currency Exchange Rate: 89.5Tk/1USD',
                        style: GoogleFonts.roboto(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        width: 1.sw,
        child: Column(
          children: [
            SizedBox(height: 10.h),
            ItemInformationCardWidget(),
            SizedBox(height: 40.h),
            OrderScreenButtonWidget(
              title: 'Checkout Now',
              leadingIcon: Icons.shopping_cart_rounded,
              onTapBehaviour: () {},
              route: MyCartScreen(),
            ),
            SizedBox(height: 20.h),
            OrderScreenButtonWidget(
              leadingIcon: Icons.shopping_cart_outlined,
              title: 'Add to Cart',
              onTapBehaviour: () {
                addToCartBottomSheet(context);
              },
            ),
            SizedBox(height: 20.h),
            OrderScreenButtonWidget(
              leadingIcon: Icons.favorite_border,
              title: 'Add to Wishlist',
              onTapBehaviour: () {
                addToWishListBottomSheet(context);
              },
            ),
            SizedBox(height: 30.h),
            CostBreakDownButtonWidget(),
          ],
        ),
      ),
    );
  }
}

class OrderScreenButtonWidget extends StatelessWidget {
  final String title;
  final IconData leadingIcon;
  final Function onTapBehaviour;
  final Widget? route;

  OrderScreenButtonWidget({
    required this.leadingIcon,
    required this.title,
    required this.onTapBehaviour,
    this.route,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        route != null
            ? Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyCartScreen()),
              )
            : SizedBox();
        onTapBehaviour();
      },
      child: Container(
        width: 240.w,
        height: 44.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: whiteColor,
          border: Border.all(color: blackColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(leadingIcon),
            Text(
              title,
              style: GoogleFonts.lato(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(
              leadingIcon,
              color: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}

class ItemInformationCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 305.w,
      height: 207.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: greyColor.withOpacity(0.4),
            spreadRadius: 0.1,
            blurRadius: 10,
            offset: Offset(0, 7),
          )
        ],
      ),
      child: Column(
        children: [
          Text(
            'Item Information',
            style: GoogleFonts.roboto(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10.h),
          ItemInformationRowWidget(
            title: 'Product Cost',
            amount: '5340Tk',
          ),
          Divider(color: yellowColor, thickness: 1),
          ItemInformationRowWidget(
            title: '5% Platform Fee',
            amount: '267Tk',
          ),
          Divider(color: yellowColor, thickness: 1),
          ItemInformationRowWidget(
            title: 'US Sales Tax (9%)',
            amount: '430Tk',
          ),
          Divider(color: yellowColor, thickness: 1),
          ItemInformationRowWidget(
            title: 'Shipping & Customs Duty',
            amount: '2000Tk',
          ),
          Divider(color: yellowColor, thickness: 1),
          ItemInformationRowWidget(
            title: 'Bangladesh VAT (12%)',
            amount: '32Tk',
          ),
          Divider(color: yellowColor, thickness: 1),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Cost',
                style: GoogleFonts.roboto(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '8069Tk',
                style: GoogleFonts.roboto(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ItemInformationRowWidget extends StatelessWidget {
  final String title;
  final String amount;
  ItemInformationRowWidget({
    required this.amount,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
            fontSize: 10.sp,
            color: blackColor.withOpacity(0.6),
          ),
        ),
        Text(
          amount,
          style: GoogleFonts.roboto(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
