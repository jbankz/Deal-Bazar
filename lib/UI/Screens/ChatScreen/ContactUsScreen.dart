import 'package:deal_bazaar/Core/Constants/Animations.dart';
import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:deal_bazaar/UI/shared/textview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/appbar.dart';

class Data {
  final Widget? image;
  final IconData? icon;
  final String? title;
  final String? link;

  Data({this.image, this.icon, this.title, this.link});

  static List<Data> medias() {
    List<Data> _medias = [];
    Data _d = Data(
        icon: Icons.whatsapp,
        title: 'WhatsApp',
        link: 'https://wa.me/+923091433933?text=Hey!');
    _medias.add(_d);
    _d = Data(
        icon: Icons.sms, title: 'Phone', link: 'sms:+923091433933?body=Hey!');
    _medias.add(_d);
    _d = Data(
        image: Lottie.asset(WhatsAppAnimtion, height: 50),
        title: 'Text us',
        link: 'https://m.me/33mshafiq');
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
            /*   Container(
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
           */

            ...Data.medias()
                .map((m) => GestureDetector(
                      onTap: () async => await launch(m.link!),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: yellowColor,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            m.image != null
                                ? Lottie.asset(WhatsAppAnimtion, height: 50)
                                : Icon(m.icon,
                                    size: 30.sp, color: Colors.green),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                m.title ?? '',
                                style: GoogleFonts.roboto(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList()
          ],
        ),
      ),
    );
  }
}
