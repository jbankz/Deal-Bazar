import 'package:deal_bazaar/marka_imports.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Core/Constants/Colors.dart';
import '../../../webview/webview_adidas.dart';
import '../../../webview/webview_amazon.dart';
import '../../../webview/webview_carter.dart';
import '../../../webview/webview_michaelKors.dart';
import '../../../webview/webview_nike.dart';
import '../../../webview/webview_saks.dart';
import '../../../webview/webview_steveMadden.dart';

class HomeScreenSearchWidget extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 295.w,
      height: 45.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: greyColor,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 190.w,
            child: TextField(
              controller: controller,
              style: GoogleFonts.roboto(
                fontSize: 16.sp,
                color: blackColor,
                fontWeight: FontWeight.w400,
              ),
              cursorColor: blackColor,
              decoration: InputDecoration(
                hintText: 'Search stores or products',
                hintStyle: GoogleFonts.roboto(
                  fontSize: 16.sp,
                  fontStyle: FontStyle.italic,
                  color: greyColor,
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          Spacer(),
          GestureDetector(
            // Search Function.
            onTap: () {
              if (controller.text.isNotEmpty && controller.text != '')
                showAlertDialog(context);
            },
            child: Center(
              child: Icon(
                Icons.search,
                color: greyColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Choose store"),
      content: Container(
        height: 300,
        width: 400,
        child: Column(children: [
          InkWell(
            onTap: () {
              print("presses");
              Get.to(WebViewAmazon(
                url: 'https://www.amazon.com/s?k=' + controller.text,
              ));
            },
            child: Container(
              width: 200,
              decoration: BoxDecoration(color: Colors.yellow),
              child: Center(
                child: Text(
                  "Amazon",
                  style: TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Get.to(WebViewAdidas(
                url: "https://www.adidas.com/us/search?q=" + controller.text,
              ));
            },
            child: Container(
              width: 200,
              decoration: BoxDecoration(color: Colors.yellow),
              child: Center(
                child: Text(
                  "Adidas",
                  style: TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Get.to(WebViewMichaelKors(
                  url: "https://www.michaelkors.com/search/_/N-0/Ntt-" +
                      controller.text));
            },
            child: Container(
              width: 200,
              decoration: BoxDecoration(color: Colors.yellow),
              child: Center(
                child: Text(
                  "Michael Kors",
                  style: TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Get.to(WebViewCarter(
                  url:
                      'https://www.carters.com/on/demandware.store/Sites-Carters-Site/default/Search-Show?q=${controller.text}&simplesearchDesktop='));
            },
            child: Container(
              width: 200,
              decoration: BoxDecoration(color: Colors.yellow),
              child: Center(
                child: Text(
                  "Carter's",
                  style: TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Get.to(WebViewNike(
                  url: 'https://www.nike.com/ca/fr/w?q=' + controller.text));
            },
            child: Container(
              width: 200,
              decoration: BoxDecoration(color: Colors.yellow),
              child: Center(
                child: Text(
                  "Nike",
                  style: TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Get.to(WebViewSteveMadden(
                  url: 'https://www.stevemadden.com/search?q=' +
                      controller.text));
            },
            child: Container(
              width: 200,
              decoration: BoxDecoration(color: Colors.yellow),
              child: Center(
                child: Text(
                  "Steve Madden",
                  style: TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Get.to(WebViewSalks(
                  url:
                      'https://www.saksfifthavenue.com/s/SaksFifthAvenue/search?q=' +
                          controller.text));
            },
            child: Container(
              width: 200,
              decoration: BoxDecoration(color: Colors.yellow),
              child: Center(
                child: Text(
                  "Salks Fifth Av..",
                  style: TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
