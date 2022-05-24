import 'package:deal_bazaar/UI/Screens/Drawer/DrawerScreen.dart';
import 'package:deal_bazaar/UI/shared/textview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/appbar.dart';
import 'widgets/gridview.dart';
import 'widgets/home_carousel.dart';
import 'widgets/search_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: CustomDrawer(),
      appBar: defaultAppBar(context,
          openDrawer: () => _key.currentState?.openDrawer()),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: ListView(
          children: [
            HomeScreenSearchWidget(),
            SizedBox(height: 10.h),
            HomeScreenCarousalSliderWidget(),
            SizedBox(height: 16.h),
            TextView(
              text: 'Top Brands & Stores are one click away',
              textAlign: TextAlign.center,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 17.h),
            HomeScreenGridViewWidget()
          ],
        ),
      ),
    );
  }
}
