import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deal_bazaar/Core/Constants/Assets.dart';
import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:deal_bazaar/Core/services/local/local_db.dart';
import 'package:deal_bazaar/UI/Screens/CartScreen/MyCartScreen.dart';
import 'package:deal_bazaar/UI/Screens/Drawer/DrawerScreen.dart';
import 'package:deal_bazaar/UI/Screens/MyWishListScreen/wishlist_tile.dart';
import 'package:deal_bazaar/UI/Screens/NotificationScreen/NotificationScreen.dart';
import 'package:deal_bazaar/UI/Screens/user_viewmodel/user_viewmodel.dart';
import 'package:deal_bazaar/UI/base_view/base_view.dart';
import 'package:deal_bazaar/core/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Core/services/database/db_service.dart';
import '../BrandPage/BrandPage.dart';
import '../CartScreen/loader_widget.dart';

class MyWishListScreen extends StatefulWidget {
  @override
  State<MyWishListScreen> createState() => _MyWishListScreenState();
}

class _MyWishListScreenState extends State<MyWishListScreen> {
  String id = "12344";
  @override
  void initState() {
    // TODO: implement initState
    LocalDb.checkUserExists().then((value) {
      if (value) {
        LocalDb.getDbID().then((value) {
          setState(() {
            id = value!;
          });
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final um = context.watch<UserViewModel>();
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
                'My Wishlist',
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
      body: StreamBuilder<List<ProductModel>>(
          stream: DbService().wishlistProducts(dbId: id),
          initialData: const [],
          builder: (context, snapshot) {
            if (snapshot.data!.length > 0) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 0.97,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 30),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return InkWell(
                          onTap: () {},
                          child: WishlistTile(product: snapshot.data![index]));
                    }),
              );
            } else if (snapshot.data!.isEmpty) {
              return Center(child: const Text('No Products in Wishlist'));
            }
            return const LoaderWidget(message: 'Fetching Wishlist Products');
          }),
    );
  }
}
