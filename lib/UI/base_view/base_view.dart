import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

export 'package:deal_bazaar/core/utils/colors.dart';
export 'package:get/get.dart';
export 'package:provider/provider.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:flutter_svg/svg.dart';
export '../../core/others/theme.dart';
export '../../core/utils/colors.dart';
export '../../core/utils/constants.dart';
export '../../core/utils/icons.dart';
export '../../core/utils/images.dart';
export '../../core/repos/repo.dart';
export '../../core/utils/text_styles.dart';

export '../../core/utils/illustrations.dart';
export '../../core/utils/mobile_info.dart';

export '../../core/models/order_status_model.dart';
export '../../core/models/product_model.dart';
export '../../core/models/websites.dart';
export 'dart:developer';

class BaseViewWidget extends StatelessWidget {
  final AppBar? appBar;
  final bool avoidScrollView;
  final Widget? body;
  final EdgeInsets? margin;
  final BottomNavigationBar? bottomNavigationBar;
  final FloatingActionButtonLocation? fabLocation;
  final Widget? fab;
  static double height = 1.0;
  static double width = 1.0;
  // _call(context) {
  //   Provider.of<MobileInfo>(context, listen: false)
  //       .setHeight(MediaQuery.of(context).size.height);
  //   Provider.of<MobileInfo>(context, listen: false)
  //       .setWidth(MediaQuery.of(context).size.width);
  // }

  // ignore: prefer_const_constructors_in_immutables
  BaseViewWidget(
      {Key? key,
      this.appBar,
      this.bottomNavigationBar,
      required this.avoidScrollView,
      this.fabLocation,
      this.fab,
      this.margin,
      this.body})
      : super(key: key);

  static devLog(String statement) {
    log(statement);
    // ignore: avoid_print
    print(statement);
  }

  @override
  Widget build(BuildContext context) {
    // _call(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return appBar != null
        ? Scaffold(
            // resizeToAvoidBottomInset: false,
            floatingActionButton: fab,
            floatingActionButtonLocation: fabLocation,

            bottomNavigationBar: bottomNavigationBar,
            appBar: appBar,

            body: SafeArea(
              child: Container(
                margin: margin ?? EdgeInsets.symmetric(horizontal: 10.w),
                height: 1.sh,
                width: 1.sw,
                child: avoidScrollView
                    ? body
                    : CustomScrollView(
                        slivers: [
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: body ?? Container(),
                          ),
                        ],
                      ),
              ),
            ),
          )
        : SafeArea(
            child: Scaffold(
              // resizeToAvoidBottomInset: false,
              bottomNavigationBar: bottomNavigationBar,

              body: Container(
                margin: margin ?? EdgeInsets.symmetric(horizontal: 20.w),
                height: 1.sh,
                width: 1.sw,
                child: avoidScrollView
                    ? body
                    : CustomScrollView(
                        slivers: [
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: body ?? Container(),
                          ),
                        ],
                      ),
              ),
            ),
          );
  }
}
