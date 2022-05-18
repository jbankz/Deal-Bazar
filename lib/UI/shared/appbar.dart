import 'package:flutter/material.dart';

import '../../Core/Constants/Assets.dart';
import '../../Core/Constants/Colors.dart';
import '../../marka_imports.dart';
import '../Screens/CartScreen/MyCartScreen.dart';

PreferredSize defaultAppBar(BuildContext context,
    {Widget? leadingWidget,
    Widget? menuWidget,
    Widget? titleWidget,
    Function()? openDrawer}) {
  Size? _size = MediaQuery.of(context).size;
  return PreferredSize(
    preferredSize: Size.fromHeight(_size.height / 15), // Set this height
    child: Container(
      height: _size.height,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: yellowColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.r),
          bottomRight: Radius.circular(15.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            leadingWidget ??
                GestureDetector(
                  onTap: openDrawer,
                  child: Icon(
                    Icons.sort,
                    size: 24.sp,
                  ),
                ),
            titleWidget ?? Image.asset(dealBazarTitle, scale: 3),
            menuWidget ??
                GestureDetector(
                  onTap: () {
                    Get.to(() => MyCartScreen());
                  },
                  child: Icon(
                    Icons.shopping_cart,
                    size: 24.sp,
                  ),
                ),
          ],
        ),
      ),
    ),
  );
}
