import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:deal_bazaar/Core/services/local/local_db.dart';
import 'package:deal_bazaar/UI/Screens/CartScreen/UpdateShippingAddressScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../BrandPage/BrandPage.dart';

class ChooseAddressScreen extends StatefulWidget {
  @override
  State<ChooseAddressScreen> createState() => _ChooseAddressScreenState();
}

class _ChooseAddressScreenState extends State<ChooseAddressScreen> {
  String name = "user";
  String phon = "+9565-392-92-95";
  String address = "12 Streat Down town,USA";
  String address2 = "12 Streat Down town,USA";
  String docId = '1234566';
  String email = 'user@gmal.com';
  String zip = '55050';
  @override
  initState() {
    LocalDb.getDbID().then((value) {
      print("here s");
      print(docId);
      FirebaseFirestore.instance
          .collection("users")
          .doc(value)
          .get()
          .then((value) {
        setState(() {
          name = value.get("fullName") ?? "user";
          phon = value.get("phoneNumber") ?? "+923323435453";
          address = value.get("addressLine") ?? "USA";
          address2 = value.get("addressLine2") ?? "USA";
          email = value.get("emailAddress") ?? 'user@user.com';
          zip = value.get("zipCode") ?? '55050';
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavGlobalHomeButtom(),
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
              Text(
                'Shipping Details',
                style: GoogleFonts.roboto(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.notifications,
                size: 26.sp,
                color: Colors.transparent,
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              'Current Shipping Address',
              style: GoogleFonts.roboto(
                fontSize: 10.sp,
                color: blackColor.withOpacity(0.5),
              ),
            ),
            ShippingDetailsCardWidget(
              address: address,
              address2: address2,
              id: docId,
              name: name,
              email: email,
              phon: phon,
              zip: zip,
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}

class ShippingDetailsCardWidget extends StatefulWidget {
  final String name;
  final String phon;
  final String email;
  final String address;
  final String address2;
  final String zip;
  final String id;

  ShippingDetailsCardWidget(
      {required this.name,
      required this.id,
      required this.phon,
      required this.email,
      required this.address,
      required this.address2,
      required this.zip});
  @override
  State<ShippingDetailsCardWidget> createState() =>
      _ShippingDetailsCardWidgetState();
}

class _ShippingDetailsCardWidgetState extends State<ShippingDetailsCardWidget> {
  bool address1 = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 302.w,
      height: 130.h,
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
                  Get.to(() => UpdateShippingAddress(
                        address: widget.address,
                        address2: widget.address2,
                        id: widget.id,
                        name: widget.name,
                        email: widget.email,
                        phon: widget.phon,
                        zip: widget.zip,
                      ));
                },
                child: Container(
                  width: 26.w,
                  height: 26.h,
                  decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(10.r),
                    color: blackColor.withOpacity(0.8),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.edit,
                      color: whiteColor,
                      size: 16.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
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
                child:
                    Text('${widget.name}, #${widget.phon}\n${widget.address}'),
              ),
            ],
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
