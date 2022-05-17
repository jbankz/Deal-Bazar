import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deal_bazaar/Core/Constants/Assets.dart';
import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:deal_bazaar/Core/services/local/local_db.dart';
import 'package:deal_bazaar/UI/Screens/CartScreen/ChooseAddressScreen.dart';

import 'package:deal_bazaar/UI/Screens/CartScreen/cart_view_model.dart';
import 'package:deal_bazaar/UI/Screens/Drawer/DrawerScreen.dart';
import 'package:deal_bazaar/UI/Screens/NotificationScreen/NotificationScreen.dart';
import 'package:deal_bazaar/UI/base_view/base_view.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:intl/intl.dart';
import '../../../Core/utils/capsule_button.dart';

import '../BrandPage/BrandPage.dart';
import '../MyOrders/custom_text.dart';
import '../user_viewmodel/user_viewmodel.dart';

class CheckoutScreen extends StatefulWidget {
  final List<ProductModel> product;
  const CheckoutScreen({
    required this.product,
    Key? key,
  }) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String address = "";
  String phon = '';
  String id = '';
  double price = 0;
  double plateformfee = 0;
  double ussalestax = 0;
  double shipingcharge = 0;
  double vat = 0;
  double total = 0;

  @override
  void initState() {
    // TODO: implement initState
    LocalDb.getDbID().then((value) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(value)
          .get()
          .then((value1) {
        setState(() {
          id = value!;
          address = value1.get("addressLine");
          phon = value1.get("phoneNumber");
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("building scrren");
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
            crossAxisAlignment: CrossAxisAlignment.center,
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
                'Checkout',
                style: GoogleFonts.roboto(
                  fontSize: 22.sp,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            _shippingCorner(context, address, phon),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cart List',
                    style: TextStyles.m_16,
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Get.back();
                            Get.back();
                          },
                          child: Icon(Icons.edit)),
                    ],
                  ),
                ],
              ),
            ),
            _table(context),

            // _cardSection(),
            SizedBox(
              height: 20.h,
            ),
            context.watch<CartViewModel>().placingOrder
                ? const Center(
                    child: CircularProgressIndicator(
                      color: MarkaColors.gold,
                    ),
                  )
                : Center(
                    child: CapsuleButton(
                      text: 'CONFIRM ORDER',
                      action: () async {
                        context.read<CartViewModel>().makePayment(
                              dbId: id,
                              finalProducts: widget.product,
                            );
                        // List<Map<String, dynamic>> _products = [];

                        // _products.add(widget.product.first.toFirebase());
                        // _products.add(widget.product[1].toFirebase());

                        // await FirebaseFirestore.instance.collection('test').doc().set({
                        //   'products': _products,
                        // });

                        // _showDialog();
                      },
                    ),
                  ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }

  _table(BuildContext context) {
    print("printing table");
    return DataTable(
        horizontalMargin: 10.w,
        border: const TableBorder(
            horizontalInside:
                BorderSide(color: MarkaColors.lightGrey, width: 2)),
        // ignore: prefer_const_literals_to_create_immutables
        columns: [
          const DataColumn(
            label: Text(
              'Items',
              style: TextStyles.r_15,
            ),
          ),
          const DataColumn(
            label: Text(
              'Qty',
              style: TextStyles.r_15,
            ),
          ),
          const DataColumn(
              label: Text(
            '\$',
            style: TextStyles.r_15,
          )),
          // ignore: prefer_const_literals_to_create_immutables
        ],
        // ignore: prefer_const_literals_to_create_immutables
        rows: widget.product.map<DataRow>((e) {
              setState(() {
                price = e.quantity! *
                    (double.parse(e.price!.replaceAll(r"$", ''))) *
                    89.5;
                plateformfee += (price * 5) / 100;
                ussalestax += (price * 9) / 100;
                shipingcharge += 193.3;
                vat += (price * 12) / 100;
                total += plateformfee + ussalestax + shipingcharge + vat;
              });

              return DataRow(
                cells: [
                  DataCell(
                    SizedBox(
                      child: Text(
                        e.title!,

                        // 'product',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      e.quantity.toString(),
                      style: TextStyles.m_12,
                    ),
                  ),
                  DataCell(
                    Text(
                      '${price}TK',
                      style: TextStyles.m_12,
                    ),
                  ),
                ],
              );
            }).toList() +
            [
              DataRow(
                cells: [
                  const DataCell(
                    Text(
                      '5% Plateform Fee',
                      style: TextStyles.m_12,
                    ),
                  ),
                  const DataCell(
                    Text(
                      '',
                      style: TextStyles.m_12,
                    ),
                  ),
                  DataCell(
                    Text(
                      '${plateformfee}TK',
                      // '${(89.5 * widget.product[p].quantity! * double.parse(widget.product[p].price!.replaceAll(r"$", '')))}TK',
                      style: TextStyles.m_12,
                    ),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  const DataCell(
                    Text(
                      'US Sales Tax (9%)',
                      style: TextStyles.m_12,
                    ),
                  ),
                  const DataCell(
                    Text(
                      '',
                      style: TextStyles.m_12,
                    ),
                  ),
                  DataCell(
                    Text(
                      '${ussalestax}TK',
                      style: TextStyles.m_12,
                    ),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  const DataCell(
                    Text(
                      'Shipping & Custom Tax',
                      style: TextStyles.m_12,
                    ),
                  ),
                  const DataCell(
                    Text(
                      '',
                      style: TextStyles.m_12,
                    ),
                  ),
                  DataCell(
                    Text(
                      '${shipingcharge}TK',
                      style: TextStyles.m_12,
                    ),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  const DataCell(
                    Text(
                      'Bangladesh VAT 12%',
                      style: TextStyles.m_12,
                    ),
                  ),
                  const DataCell(
                    Text(
                      '',
                      style: TextStyles.m_12,
                    ),
                  ),
                  DataCell(
                    Text(
                      "${vat}TK",
                      style: TextStyles.m_12,
                    ),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  // ignore: prefer_const_constructors
                  DataCell(
                    const Text(
                      'Total Payment',
                      style: TextStyles.b_16,
                    ),
                  ),
                  const DataCell(
                    Text(
                      '',
                      style: TextStyles.m_12,
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 2.w,
                          ),
                          FittedBox(
                            child: Text(
                              '${total}TK',
                              style: TextStyles.b_20
                                  .copyWith(overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          Expanded(
                            child: AutoSizeText(
                              "total",
                              // NumberFormat("###,###.0#", "en_US")
                              //     .format(context.watch<CartViewModel>().grandTotal)
                              //     .toString(),
                              // '10,00,00,00,00,00,00',
                              maxFontSize: 20,
                              style: TextStyles.retTextStyle(
                                  TextStyles.b_20, MarkaColors.yellow),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ]);
  }

  _shippingCorner(BuildContext context, String address, String phon) {
    print("shiping corner");
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: MarkaColors.darkGrey,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_box,
                    color: Colors.white,
                  ),
                  const Text(
                    'My Shipping Address',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Get.to(ChooseAddressScreen());
                },
                child: const Text(
                  'Change',
                  style: TextStyles.r_10,
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on,
                color: Colors.white,
              ),
              Flexible(
                  child: Text(
                address + "\n" + phon,
                style: TextStyle(color: Colors.white),
              )),
            ],
          ),
        ],
      ),
    );
  }

  // ignore: unused_element
  _cardSection() {
    print("card section");
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 0.h),
      decoration: BoxDecoration(
        color: MarkaColors.darkGrey,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Change",
                  style: TextStyles.r_10,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.card_membership),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    "**** **** **** 8173",
                    style: TextStyles.m_16,
                  ),
                  const Text(
                    "Expires 07/2025",
                    style: TextStyles.r_12,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }
}

class ShippingAddressCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 302.w,
      height: 100.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: greyColor.withOpacity(0.5),
            blurRadius: 5,
            spreadRadius: 0.1,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.check_box,
                color: greenColor,
              ),
              SizedBox(width: 10.w),
              Text(
                'My Shipping Address',
                style: GoogleFonts.roboto(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to(() => ChooseAddressScreen());
                },
                child: Text(
                  'Change',
                  style: GoogleFonts.roboto(
                    fontSize: 10.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Container(
                width: 25.w,
                height: 25.h,
                decoration: BoxDecoration(
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: greyColor.withOpacity(0.5),
                      blurRadius: 5,
                      spreadRadius: 0.1,
                      offset: Offset(0, 4),
                    ),
                  ],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.location_on,
                  color: redColor,
                ),
              ),
              SizedBox(width: 10.w),
              SizedBox(
                width: 170.w,
                child: Text(
                  'Quin Beck, #+965-392-93-492 '
                  '12 Streat Down town,USA',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CartListItemsAndTotalWidget extends StatelessWidget {
  const CartListItemsAndTotalWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                'Items',
                style: GoogleFonts.roboto(
                  fontSize: 15.sp,
                  color: greyColor,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Qty',
                style: GoogleFonts.roboto(
                  fontSize: 15.sp,
                  color: greyColor,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Tk',
                style: GoogleFonts.roboto(
                  fontSize: 15.sp,
                  color: greyColor,
                ),
              ),
            ),
          ],
        ),
        Divider(color: blackColor),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                'Gaming Headset',
                style: GoogleFonts.roboto(
                  fontSize: 12.sp,
                  color: greyColor,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '1',
                style: GoogleFonts.roboto(
                  fontSize: 12.sp,
                  color: greyColor,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '24.99',
                style: GoogleFonts.roboto(
                  fontSize: 12.sp,
                  color: greyColor,
                ),
              ),
            ),
          ],
        ),
        Divider(color: blackColor),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: Text(
                'Shipping Charges',
                style: GoogleFonts.roboto(
                  fontSize: 12.sp,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '20',
                style: GoogleFonts.roboto(
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: Text(
                'Shipping Charges',
                style: GoogleFonts.roboto(
                  fontSize: 12.sp,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '15',
                style: GoogleFonts.roboto(
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
        ),
        Divider(color: blackColor),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: Text(
                'Total Payment',
                style: GoogleFonts.roboto(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tk',
                    style: GoogleFonts.roboto(
                      fontSize: 8.sp,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    '3122',
                    style: GoogleFonts.roboto(
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class WishListCardWidget extends StatelessWidget {
  const WishListCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 285.w,
      height: 55.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: greyColor.withOpacity(0.2),
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      blackColor,
                      blackColor.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
              Image.asset(watchimage),
            ],
          ),
          SizedBox(width: 20.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 5.h),
              Text(
                'Rolex Watch',
                style: GoogleFonts.roboto(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                'Amazon',
                style: GoogleFonts.roboto(
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 5.h),
              Icon(
                Icons.close,
              ),
              Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tk',
                    style: GoogleFonts.roboto(
                      fontSize: 8.sp,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    '99.99',
                    style: GoogleFonts.roboto(
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
            ],
          )
        ],
      ),
    );
  }
}
