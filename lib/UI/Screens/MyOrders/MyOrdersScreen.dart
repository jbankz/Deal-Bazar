import 'package:deal_bazaar/Core/Constants/Assets.dart';
import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:deal_bazaar/UI/Screens/CartScreen/MyCartScreen.dart';
import 'package:deal_bazaar/UI/Screens/Drawer/DrawerScreen.dart';
import 'package:deal_bazaar/UI/Screens/MyOrders/MyOrderDetailsScreen.dart';
import 'package:deal_bazaar/UI/Screens/MyOrders/order_status_tile.dart';
import 'package:deal_bazaar/UI/Screens/MyOrders/order_tracking_view.dart';
import 'package:deal_bazaar/UI/Screens/NotificationScreen/NotificationScreen.dart';
import 'package:deal_bazaar/UI/base_view/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Core/services/database/db_service.dart';
import '../../../marka_imports.dart';
import '../BrandPage/BrandPage.dart';
import '../CartScreen/loader_widget.dart';
import '../user_viewmodel/user_viewmodel.dart';

class MyOrderScreen extends StatefulWidget {
  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  bool isDelivered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavGlobalHomeButtom(),
      drawer: CustomDrawer(),
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
              Builder(
                builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: Image.asset(
                      mainPageMenuIcon,
                      scale: 3,
                    ),
                  );
                },
              ),
              Text(
                'My Orders',
                style: GoogleFonts.roboto(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => NotificationScreen());
                },
                child: Icon(
                  Icons.notifications,
                  size: 30.sp,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h),
          Container(
            height: 52.h,
            width: 1.sw,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    isDelivered = false;
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: isDelivered ? Colors.transparent : blackColor,
                        borderRadius: BorderRadius.circular(50.r)),
                    width: 150.w,
                    height: 34.h,
                    child: Center(
                      child: Text(
                        "Delivered",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: isDelivered ? greyColor : yellowColor),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    isDelivered = true;
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: isDelivered ? blackColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(50.r)),
                    width: 150.w,
                    height: 34.h,
                    child: Center(
                      child: Text(
                        "Pending",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: isDelivered ? yellowColor : greyColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          DelieveredOrdersView()
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class DelieveredOrdersView extends StatelessWidget {
  const DelieveredOrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final um = context.watch<UserViewModel>();

    return BaseViewWidget(
        avoidScrollView: true,
        body:
            Container() /*Expanded(
        child: Column(
          children: [
            StreamBuilder<List<OrderStatusModel>>(
                stream:
                    DbService().delieveredOrders(dbId: um.user.dbId.toString()),
                initialData: const [],
                builder: (context, snapshot) {
                  log(snapshot.data!.length.toString());
                  if (snapshot.data!.isNotEmpty) {
                    //   return Container();
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (ctx, index) {
                          return InkWell(
                              onTap: () => Get.to(() => OrderTrackingView(
                                  order: snapshot.data![index])),
                              child: OrderStatusTile(
                                  order: snapshot.data![index]));
                        });
                  } else if (snapshot.data!.isEmpty) {
                    return const Text('No Order Placed');
                  }
                  return const LoaderWidget(message: 'Fetching Order Placed');
                }),
          ],
        ),
      ),*/
        );
  }
}
