import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:deal_bazaar/Core/services/local/local_db.dart';
import 'package:deal_bazaar/UI/Screens/CartScreen/UpdateShippingAddressScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/appbar.dart';
import '../../shared/textview.dart';
import '../BrandPage/BrandPage.dart';
import '../NotificationScreen/NotificationScreen.dart';

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
      appBar: defaultAppBar(context,
          leadingWidget: GestureDetector(
              onTap: () => Get.back(), child: Icon(Icons.clear)),
          titleWidget: TextView(
              text: 'Shipping Details',
              fontSize: 20,
              fontWeight: FontWeight.w600),
          menuWidget: GestureDetector(
            onTap: () {
              Get.to(() => NotificationScreen());
            },
            child: Icon(Icons.notifications, size: 24.sp),
          )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            TextView(
              text: 'Current Shipping Address',
              fontSize: 14,
              textAlign: TextAlign.left,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 16.h),
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
    Size? _size = MediaQuery.of(context).size;
    return Container(
      width: _size.width.w,
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'My Shipping Address',
                  style: GoogleFonts.roboto(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
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
          SizedBox(height: 16.h),
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
              Expanded(
                child: TextView(
                    text: '${widget.name}, #${widget.phon}\n${widget.address}'),
              ),
            ],
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
