import 'package:deal_bazaar/Core/Constants/Assets.dart';
import 'package:deal_bazaar/Core/services/database/db_service.dart';
import 'package:deal_bazaar/Core/services/local/local_db.dart';
import 'package:deal_bazaar/Core/utils/capsule_button.dart';
import 'package:deal_bazaar/UI/Screens/BrandPage/BrandPage.dart';
import 'package:deal_bazaar/UI/Screens/BrandPage/OrderScreen.dart';
import 'package:deal_bazaar/UI/Screens/CartScreen/CheckoutScreen.dart';
import 'package:deal_bazaar/UI/Screens/CartScreen/cart_tile.dart';
import 'package:deal_bazaar/UI/Screens/CartScreen/cart_view_model.dart';
import 'package:deal_bazaar/UI/Screens/CartScreen/loader_widget.dart';
import 'package:deal_bazaar/UI/Screens/Drawer/DrawerScreen.dart';
import 'package:deal_bazaar/UI/Screens/NotificationScreen/NotificationScreen.dart';
import 'package:deal_bazaar/UI/Screens/user_viewmodel/user_viewmodel.dart';
import 'package:deal_bazaar/UI/base_view/base_view.dart';
import 'package:deal_bazaar/UI/shared/textview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Core/Constants/Colors.dart';
import '../../shared/appbar.dart';

class MyCartScreen extends StatefulWidget {
  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  FirebaseAuth user = FirebaseAuth.instance;

  String id = '12344';

  @override
  initState() {
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
      appBar: defaultAppBar(context,
          leadingWidget: GestureDetector(
              onTap: () => Get.back(), child: Icon(Icons.clear)),
          titleWidget: TextView(
              text: 'My cart', fontSize: 20, fontWeight: FontWeight.w600),
          menuWidget: GestureDetector(
            onTap: () {
              Get.to(() => NotificationScreen());
            },
            child: Icon(Icons.notifications, size: 24.sp),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<List<ProductModel>>(
                stream: DbService().cartProducts(dbId: id),
                initialData: const [],
                builder: (ctx, snapshot) {
                  log('Snapshot id: ' + id);
                  log('Snapshot Length: ' + snapshot.data!.length.toString());
                  if (snapshot.data!.isNotEmpty) {
                    return Column(
                      children: [
                        for (int index = 0;
                            index < snapshot.data!.length;
                            index++)
                          // Container(
                          //   margin: EdgeInsets.symmetric(vertical: 5.0),
                          //   // height: 10,
                          //   // width: 10,
                          //   color: MarkaColors.gold,
                          //   child: Text(snapshot.data![index].title.toString()),
                          // ),

                          // CartTile(
                          //   product: snapshot.data![index],
                          //   quantity: 1,
                          // ),
                          CartTile(
                              cancelAction: () {
                                // DbService().deleteFromCart(dbId: context.watch<UserViewModel>.user
                                DbService().deleteFromCart(
                                    dbId: id,
                                    id: snapshot.data![index].id.toString());
                              },
                              product: snapshot.data![index],
                              decreaseAction: () {
                                if (snapshot.data![index].quantity! > 1) {
                                  DbService().decreaseProductQuantityInCart(
                                      quan: snapshot.data![index].quantity!
                                          .toInt(),
                                      dbId: id,
                                      id: snapshot.data![index].id.toString());
                                }
                              },
                              quantity: 1,
                              increaseAction: () {
                                DbService().increaseProductQuantityInCart(
                                    quan:
                                        snapshot.data![index].quantity!.toInt(),
                                    dbId: id,
                                    id: snapshot.data![index].id.toString());
                              }),
                        SizedBox(
                          height: 20.h,
                        ),
                        CapsuleButton(
                          text: 'Check Out',
                          action: () {
                            Provider.of<CartViewModel>(context, listen: false)
                                .clearProductPrices();

                            Provider.of<CartViewModel>(context, listen: false)
                                .reinitialize();

                            Provider.of<CartViewModel>(context, listen: false)
                                .generateTrackingId();
                            for (int c = 0; c < snapshot.data!.length; c++) {
                              Provider.of<CartViewModel>(context, listen: false)
                                  .calculatePriceWithQuantity(
                                      quantity:
                                          snapshot.data![c].quantity!.toInt(),
                                      price: snapshot.data![c].price!);
                            }
                            for (int c = 0; c < snapshot.data!.length; c++) {
                              print("price product " +
                                  snapshot.data![c].shippingCost.toString());
                              Provider.of<CartViewModel>(context, listen: false)
                                  .calculateSCWithQuantity(
                                      quantity:
                                          snapshot.data![c].quantity!.toInt(),
                                      price:
                                          snapshot.data![c].shippingCost ?? 0);
                              Provider.of<CartViewModel>(context, listen: false)
                                  .calculateDeliveryCostWithQuantity(
                                length: snapshot.data![c].quantity!.toInt(),
                              );
                            }

                            Provider.of<CartViewModel>(context, listen: false)
                                .calculateCustomCostWithQuantity(
                                    products: snapshot.data!);

                            Get.to(() => CheckoutScreen(
                                  product: snapshot.data!,
                                ));
                          },
                        ),
                      ],
                    );
                  } else if (snapshot.data!.isEmpty) {
                    return Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child:
                            Center(child: const Text('No Products in Cart')));
                  }
                  return const LoaderWidget(message: 'Fetching Cart Products');
                }),
          ],
        ),
      ),
    );
  }
}

class MyCartCardWidget extends StatefulWidget {
  final bool isShadow;
  final bool isMargin;

  MyCartCardWidget({
    required this.isShadow,
    required this.isMargin,
  });

  @override
  State<MyCartCardWidget> createState() => _MyCartCardWidgetState();
}

class _MyCartCardWidgetState extends State<MyCartCardWidget> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        cartItemPopUp(context);
      },
      child: Container(
        margin: widget.isMargin
            ? EdgeInsets.symmetric(vertical: 10.h)
            : EdgeInsets.zero,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            widget.isShadow
                ? BoxShadow(
                    color: greyColor.withOpacity(0.5),
                    blurRadius: 5,
                    spreadRadius: 0.1,
                    offset: Offset(0, 4),
                  )
                : BoxShadow(),
          ],
        ),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        yellowColor,
                        yellowColor.withOpacity(0.4),
                      ],
                    ),
                  ),
                ),
                Image.asset(watchimage, height: 65.h)
              ],
            ),
            SizedBox(width: 20.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rolex Watch',
                  style: GoogleFonts.roboto(
                    color: blackColor.withOpacity(0.5),
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tk',
                      style: GoogleFonts.roboto(
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      '8096',
                      style: GoogleFonts.roboto(
                        fontSize: 20.sp,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(
                  Icons.close,
                  size: 15.sp,
                  color: greyColor,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          count <= 1 ? count : count--;
                        });
                      },
                      child: Icon(
                        Icons.remove_circle,
                        color: count == 1 ? greyColor : blackColor,
                      ),
                    ),
                    Container(
                      width: 39.w,
                      height: 14.h,
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            color: greyColor.withOpacity(0.5),
                            blurRadius: 5,
                            spreadRadius: 0.1,
                            offset: Offset(3, 3),
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(count.toString()),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        count++;
                        setState(() {});
                      },
                      child: Icon(
                        Icons.add_circle,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Future<Object?> cartItemPopUp(BuildContext context) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    // barrierColor: Colors.black45,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (BuildContext buildContext, Animation animation,
        Animation secondaryAnimation) {
      return Center(
        child: Container(
          width: 1.sw,
          height: 0.5.sh,
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                borderRadius: BorderRadius.circular(10.r),
                child: MyCartCardWidget(
                  isShadow: false,
                  isMargin: false,
                ),
              ),
              SizedBox(height: 10.h),
              Material(
                borderRadius: BorderRadius.circular(10.r),
                child: ItemInformationCardWidget(),
              ),
            ],
          ),
        ),
      );
    },
  );
}
