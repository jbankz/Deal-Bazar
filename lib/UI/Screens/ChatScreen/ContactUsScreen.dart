import 'package:deal_bazaar/Core/Constants/Animations.dart';
import 'package:deal_bazaar/Core/Constants/Assets.dart';
import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:deal_bazaar/UI/Screens/CartScreen/MyCartScreen.dart';
import 'package:deal_bazaar/UI/shared/textview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../shared/appbar.dart';
import '../BrandPage/BrandPage.dart';
import 'package:url_launcher/url_launcher.dart';

class Data {
  final String? image;
  final String? title;
  final String? link;

  Data({this.image, this.title, this.link});

  static List<Data> medias() {
    List<Data> _medias = [];
    Data _d = Data(image: '', title: '', link: '');
    _medias.add(_d);
    return _medias;
  }
}

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size? _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: defaultAppBar(
        context,
        leadingWidget:
            GestureDetector(onTap: () => Get.back(), child: Icon(Icons.clear)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: ListView(
          children: [
            Lottie.asset(
              chatBotAnimation,
              height: 100.h,
              width: 100.w,
            ),
            TextView(
              text: 'Agent available 24 hours',
              fontSize: 20,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            Container(
              width: _size.width.w,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: yellowColor,
                  width: 2,
                ),
              ),
              child: InkWell(
                onTap: () async {
                  const url = "https://wa.me/+923091433933?text=Hey!";

                  await launch(url);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.whatsapp,
                      size: 30,
                      color: Colors.green,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        'WhatsApp',
                        style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward,
                      size: 25,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              width: _size.width.w,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: yellowColor,
                  width: 2,
                ),
              ),
              child: InkWell(
                onTap: () async {
                  await launch('sms:+923091433933?body=Hey! ');
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.sms,
                      size: 30,
                      color: Colors.lightBlue,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        'Phone Message',
                        style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward,
                      size: 25,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              width: _size.width.w,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: yellowColor,
                  width: 2,
                ),
              ),
              child: InkWell(
                onTap: () async {
                  const url = "https://m.me/33mshafiq";

                  await launch(url);
                },
                child: Row(
                  children: [
                    Lottie.asset(WhatsAppAnimtion, height: 50),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        'Text us',
                        style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward,
                      size: 25,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
