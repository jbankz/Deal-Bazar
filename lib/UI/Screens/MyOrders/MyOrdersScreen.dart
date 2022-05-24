import 'package:deal_bazaar/UI/Screens/NotificationScreen/NotificationScreen.dart';
import 'package:deal_bazaar/UI/base_view/base_view.dart';
import 'package:flutter/material.dart';

import '../../../Core/Constants/Colors.dart';
import '../../../marka_imports.dart';
import '../../shared/appbar.dart';
import '../../shared/textview.dart';

class MyOrderScreen extends StatefulWidget {
  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  bool isDelivered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context,
          leadingWidget: GestureDetector(
              onTap: () => Get.back(), child: Icon(Icons.clear)),
          titleWidget: TextView(
              text: 'My Orders', fontSize: 20, fontWeight: FontWeight.w600),
          menuWidget: GestureDetector(
            onTap: () {
              Get.to(() => NotificationScreen());
            },
            child: Icon(Icons.notifications, size: 24.sp),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _tab(
                      text: 'Delivered',
                      selected: isDelivered,
                      defaultV: true,
                      onTap: () {
                        isDelivered = false;
                        setState(() {});
                      }),
                  _tab(
                      text: 'Pending',
                      selected: isDelivered,
                      defaultV: false,
                      onTap: () {
                        isDelivered = true;
                        setState(() {});
                      }),
                ],
              ),
              SizedBox(height: 20.h),
              /* DelieveredOrdersView() */
            ],
          ),
        ),
      ),
    );
  }

  Widget _tab({
    required String? text,
    required Function()? onTap,
    required bool? defaultV,
    required bool? selected,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: selected == defaultV ? Colors.transparent : blackColor,
              borderRadius: BorderRadius.circular(50.r)),
          width: 150.w,
          height: 34.h,
          child: Center(
            child: Text(
              text!,
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: selected == defaultV ? greyColor : yellowColor),
            ),
          ),
        ),
      );
}
