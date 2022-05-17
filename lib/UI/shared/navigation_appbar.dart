import 'package:deal_bazaar/UI/Screens/NotificationScreen/NotificationScreen.dart';
import 'package:flutter/material.dart';
import 'package:deal_bazaar/ui/base_view/base_view.dart';

AppBar? navigationAppBar(
        {required String title, Color? textColor, Widget? leadingWidget}) =>
    AppBar(
      backgroundColor: MarkaColors.black,
      centerTitle: true,
      // leading: leadingWidget ??
      //     InkWell(
      //       onTap: () {},
      //       child: Container(
      //         margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
      //         child: SvgPicture.asset(
      //           MarkaIcons.hamburgerMenuIcon,
      //         ),
      //       ),
      //     ),
      elevation: 0.0,
      title: Text(title,
          style: TextStyle(color: textColor ?? MarkaColors.lightGrey)),
      actions: [
        InkWell(
          onTap: () => Get.to(() => NotificationScreen()),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
            child: SvgPicture.asset(
              MarkaIcons.notificationMenuIcon,
            ),
          ),
        ),
      ],
    );

AppBar? backNavigationAppBar(
        {required String title, Color? textColor, Widget? leadingWidget}) =>
    AppBar(
      backgroundColor: MarkaColors.black,
      centerTitle: true,
      leading: InkWell(
        onTap: () => Get.back(),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            color: MarkaColors.white,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: const Center(
            child: Icon(
              Icons.arrow_back_ios,
              color: MarkaColors.lightGreen,
            ),
          ),
        ),
      ),
      elevation: 0.0,
      title: Text(title,
          style: TextStyle(color: textColor ?? MarkaColors.lightGrey)),
    );

AppBar? navigationAppBar2(
        {required String title,
        Color? textColor,
        Widget? leadingWidget,
        Widget? trailingWidget}) =>
    AppBar(
      backgroundColor: Colors.yellow,
      centerTitle: true,
      leading: leadingWidget ??
          InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
              child: SvgPicture.asset(
                MarkaIcons.hamburgerMenuIcon,
              ),
            ),
          ),
      elevation: 0.0,
      title: Column(
        children: [
          Text("Deal Bazaar",
              style: TextStyle(color: MarkaColors.black, fontSize: 23)),
          Text(
            "BIG BRANDS SMALL PRICES",
            style: TextStyle(
                color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
          )
        ],
      ),
      actions: [
        InkWell(
          onTap: () => Get.to(() => NotificationScreen()),
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
              child: Icon(
                Icons.notifications,
                color: Colors.black,
                size: 30,
              )),
        ),
      ],
    );
