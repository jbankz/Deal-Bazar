import 'package:carousel_slider/carousel_slider.dart';
import 'package:deal_bazaar/Core/Constants/Assets.dart';
import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:deal_bazaar/UI/Screens/BrandPage/BrandPage.dart';
import 'package:deal_bazaar/UI/Screens/BrandPage/BrandPage2.dart';
import 'package:deal_bazaar/UI/Screens/CartScreen/MyCartScreen.dart';
import 'package:deal_bazaar/UI/Screens/Drawer/DrawerScreen.dart';
import 'package:deal_bazaar/UI/webview/webview_adidas.dart';
import 'package:deal_bazaar/UI/webview/webview_amazon.dart';
import 'package:deal_bazaar/UI/webview/webview_carter.dart';
import 'package:deal_bazaar/UI/webview/webview_michaelKors.dart';
import 'package:deal_bazaar/UI/webview/webview_nike.dart';
import 'package:deal_bazaar/UI/webview/webview_nordstorm.dart';
import 'package:deal_bazaar/UI/webview/webview_saks.dart';
import 'package:deal_bazaar/UI/webview/webview_steveMadden.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../webview/webview_macys.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.h), // Set this height
        child: Container(
          width: 325.w,
          height: 105.h,
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
              Image.asset(
                dealBazarTitle,
                scale: 2.5,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => MyCartScreen());
                },
                child: Icon(
                  Icons.shopping_cart,
                  size: 30.sp,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 1.sh,
          width: 1.sw,
          child: Column(
            children: [
              SizedBox(height: 20.h),
              HomeScreenSearchWidget(),
              SizedBox(height: 10.h),
              Container(
                height: 200.h,
                child: HomeScreenCarousalSliderWidget(),
              ),
              SizedBox(height: 5.h),
              Text(
                'Top Brands & Stores are one click away',
                style: GoogleFonts.roboto(
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 17.h),
              HomeScreenGridViewWidget(),
              // SizedBox(
              //   height: 30,
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreenGridViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: 9,
        padding: EdgeInsets.only(right: 20.w, left: 20.w, bottom: 50.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20.w,
          mainAxisSpacing: 25.h,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              print(index);
              if (index == 0) {
                Get.to(
                  () => WebViewMichaelKors(
                    url: 'https://www.michaelkors.com',
                  ),
                );
              }
              if (index == 1) {
                Get.to(
                  () => WebViewAdidas(
                    url: 'https://www.adidas.com/us',
                  ),
                );
              }
              if (index == 2) {
                Get.to(
                  () => WebViewAmazon(
                    url: 'https://www.amazon.com',
                  ),
                );
              }
              if (index == 3) {
                Get.to(
                  () => WebViewMacys(),
                );
              }
              if (index == 4) {
                Get.to(
                  () => WebViewNike(
                    url: 'https://www.nike.com',
                  ),
                );
              }
              if (index == 5) {
                Get.to(
                  () => WebViewCarter(
                    url: 'https://www.carters.com',
                  ),
                );
              }
              if (index == 6) {
                Get.to(
                  () => WebViewSteveMadden(
                    url: 'https://www.stevemadden.com',
                  ),
                );
              }
              if (index == 7) {
                Get.to(
                  () => WebViewNordStorm(),
                );
              }
              if (index == 8) {
                Get.to(
                  () => WebViewSalks(
                    url: 'https://www.saksfifthavenue.com',
                  ),
                );
              }
            },
            child: Container(
              width: 83.w,
              height: 83.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: greyColor.withOpacity(0.5),
                    blurRadius: 3,
                    spreadRadius: 0.1,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(
                  brandImageAddresses[index],
                  scale: 4,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class HomeScreenCarousalSliderWidget extends StatefulWidget {
  @override
  _HomeScreenCarousalSliderWidgetState createState() =>
      _HomeScreenCarousalSliderWidgetState();
}

class _HomeScreenCarousalSliderWidgetState
    extends State<HomeScreenCarousalSliderWidget> {
  int _current = 0;

  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CarouselSlider(
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(
                  () {
                    _current = index;
                  },
                );
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageSliders.asMap().entries.map(
            (entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (_current == entry.key
                        ? yellowColor
                        : greyColor.withOpacity(0.2)),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}

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
            child: Container(
              width: 30.h,
              height: 30.h,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(7.r),
                boxShadow: [
                  BoxShadow(
                    color: greyColor.withOpacity(0.5),
                    blurRadius: 5,
                    spreadRadius: 0.1,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.search,
                  color: greyColor,
                ),
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
