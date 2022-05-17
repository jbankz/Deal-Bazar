import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:deal_bazaar/Core/services/local/local_db.dart';
import 'package:deal_bazaar/UI/Model/DrawerModel.dart';
import 'package:deal_bazaar/UI/Screens/CartScreen/ChooseAddressScreen.dart';
import 'package:deal_bazaar/UI/Screens/CartScreen/MyCartScreen.dart';
import 'package:deal_bazaar/UI/Screens/ChatScreen/ContactUsScreen.dart';
import 'package:deal_bazaar/UI/Screens/MyOrders/MyOrdersScreen.dart';
import 'package:deal_bazaar/UI/Screens/MyWishListScreen/MyWishListScreen.dart';
import 'package:deal_bazaar/UI/Screens/NotificationScreen/NotificationScreen.dart';
import 'package:deal_bazaar/UI/Screens/SignUp_SignIn_Screens/SignIn_SignUpScreen.dart';
import 'package:deal_bazaar/UI/Screens/TutorialScreen/TutorialsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_share/flutter_share.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  final int drawerButtom = 1;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Column(
        children: [
          Container(
            width: 281.w,
            height: 173.h,
            decoration: BoxDecoration(
              color: yellowColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.r),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.person,
                  size: 70.sp,
                  color: blackColor,
                ),
                Text(
                  'Quinn Beck',
                  style: GoogleFonts.roboto(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'quinnbeck@dealbazaar.com',
                  style: GoogleFonts.roboto(
                    fontSize: 10.sp,
                  ),
                ),
                SizedBox(height: 13.h),
              ],
            ),
          ),
          // drawerButton: context.watch<DrawerModel>().drawerNo,
          Expanded(
            child: Container(
              color: blackColor,
              child: Column(
                children: [
                  SizedBox(height: 44.h),
                  DrawerButtonWidget(
                    drawerButton: 1,
                    title: 'All Orders',
                    leadingIcon: Icons.list_alt_rounded,
                    routeTo: MyOrderScreen(),
                  ),
                  DrawerButtonWidget(
                    drawerButton: 2,
                    title: 'My Cart',
                    leadingIcon: Icons.shopping_cart,
                    routeTo: MyCartScreen(),
                  ),
                  DrawerButtonWidget(
                    drawerButton: 3,
                    title: 'My Wishlist',
                    leadingIcon: Icons.edit_location_alt_outlined,
                    routeTo: MyWishListScreen(),
                  ),
                  DrawerButtonWidget(
                    drawerButton: 4,
                    title: 'My Shipping Details',
                    leadingIcon: Icons.edit_location,
                    routeTo: ChooseAddressScreen(),
                  ),
                  DrawerButtonWidget(
                    drawerButton: 5,
                    title: 'Notifications',
                    leadingIcon: Icons.list_alt_sharp,
                    routeTo: NotificationScreen(),
                  ),
                  DrawerButtonWidget(
                    drawerButton: 6,
                    title: 'Support',
                    leadingIcon: Icons.chat,
                    routeTo: ChatScreen(),
                  ),
                  DrawerButton(
                    drawerButton: 7,
                    title: 'Share Deal Bazaar',
                    leadingIcon: Icons.share,
                  ),
                  DrawerButtonWidget(
                    drawerButton: 8,
                    title: 'Tutorials',
                    leadingIcon: Icons.file_copy,
                    routeTo: TutorialScreen(),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      LocalDb.removeDbValue();
                      Get.offAll(() => SignInSignUpScreen());
                    },
                    child: Container(
                      width: 144.w,
                      height: 33.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: redColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout,
                            color: whiteColor,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            'Log Out',
                            style: GoogleFonts.roboto(
                              fontSize: 16.sp,
                              color: whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DrawerButton extends StatefulWidget {
  final int drawerButton;
  final IconData leadingIcon;
  final String title;
  final Widget? routeTo;

  DrawerButton({
    required this.drawerButton,
    required this.leadingIcon,
    required this.title,
    this.routeTo,
  });

  @override
  State<DrawerButton> createState() => _DrawerButtonState();
}

class _DrawerButtonState extends State<DrawerButton> {
  bool isLogin = false;
  check() {
    LocalDb.checkUserExists().then((value) {
      if (value) {
        setState(() {
          isLogin = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    check();
    return GestureDetector(
      onTap: () async {
        widget.drawerButton == 1
            ? context.read<DrawerModel>().page1()
            : widget.drawerButton == 2
                ? context.read<DrawerModel>().page2()
                : widget.drawerButton == 3
                    ? context.read<DrawerModel>().page3()
                    : widget.drawerButton == 4
                        ? context.read<DrawerModel>().page4()
                        : widget.drawerButton == 5
                            ? context.read<DrawerModel>().page5()
                            : widget.drawerButton == 6
                                ? context.read<DrawerModel>().page6()
                                : widget.drawerButton == 7
                                    ? context.read<DrawerModel>().page7()
                                    : context.read<DrawerModel>().page8();

        await FlutterShare.share(
          title: 'Deal Bazaar',
          text: 'You can get deal bazaar from this link',
          linkUrl:
              'https://drive.google.com/file/d/1uQklzGMmuKZLP4gq7UHBx_-IjeU_ab7m/view?usp=sharing',
        );
      },
      child: Container(
        width: 281.w,
        height: 46.h,
        decoration: BoxDecoration(
          color: context.watch<DrawerModel>().drawerNo == widget.drawerButton
              ? greyColor.withOpacity(0.3)
              : blackColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.r),
            bottomRight: Radius.circular(30.r),
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: 10.w),
            context.watch<DrawerModel>().drawerNo == widget.drawerButton
                ? Container(
                    width: 2.w,
                    height: 21.h,
                    decoration: BoxDecoration(
                      color: yellowColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  )
                : Container(),
            SizedBox(width: 5.w),
            Icon(
              widget.leadingIcon,
              size: 20.sp,
              color:
                  context.watch<DrawerModel>().drawerNo == widget.drawerButton
                      ? yellowColor
                      : whiteColor,
            ),
            SizedBox(width: 10.w),
            Text(
              widget.title,
              style: GoogleFonts.roboto(
                color:
                    context.watch<DrawerModel>().drawerNo == widget.drawerButton
                        ? yellowColor
                        : whiteColor,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerButtonWidget extends StatefulWidget {
  final int drawerButton;
  final IconData leadingIcon;
  final String title;
  final Widget? routeTo;

  DrawerButtonWidget({
    required this.drawerButton,
    required this.leadingIcon,
    required this.title,
    this.routeTo,
  });

  @override
  State<DrawerButtonWidget> createState() => _DrawerButtonWidgetState();
}

class _DrawerButtonWidgetState extends State<DrawerButtonWidget> {
  bool isLogin = false;
  check() {
    LocalDb.checkUserExists().then((value) {
      if (value) {
        setState(() {
          isLogin = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    check();
    return GestureDetector(
      onTap: () {
        widget.drawerButton == 1
            ? context.read<DrawerModel>().page1()
            : widget.drawerButton == 2
                ? context.read<DrawerModel>().page2()
                : widget.drawerButton == 3
                    ? context.read<DrawerModel>().page3()
                    : widget.drawerButton == 4
                        ? context.read<DrawerModel>().page4()
                        : widget.drawerButton == 5
                            ? context.read<DrawerModel>().page5()
                            : widget.drawerButton == 6
                                ? context.read<DrawerModel>().page6()
                                : widget.drawerButton == 7
                                    ? context.read<DrawerModel>().page7()
                                    : context.read<DrawerModel>().page8();

        widget.routeTo != null
            ? Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => widget.routeTo!),
              )
            : SizedBox();
      },
      child: Container(
        width: 281.w,
        height: 46.h,
        decoration: BoxDecoration(
          color: context.watch<DrawerModel>().drawerNo == widget.drawerButton
              ? greyColor.withOpacity(0.3)
              : blackColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.r),
            bottomRight: Radius.circular(30.r),
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: 10.w),
            context.watch<DrawerModel>().drawerNo == widget.drawerButton
                ? Container(
                    width: 2.w,
                    height: 21.h,
                    decoration: BoxDecoration(
                      color: yellowColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  )
                : Container(),
            SizedBox(width: 5.w),
            Icon(
              widget.leadingIcon,
              size: 20.sp,
              color:
                  context.watch<DrawerModel>().drawerNo == widget.drawerButton
                      ? yellowColor
                      : whiteColor,
            ),
            SizedBox(width: 10.w),
            Text(
              widget.title,
              style: GoogleFonts.roboto(
                color:
                    context.watch<DrawerModel>().drawerNo == widget.drawerButton
                        ? yellowColor
                        : whiteColor,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
