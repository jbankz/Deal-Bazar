import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:deal_bazaar/marka_imports.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../../../../Core/Constants/Assets.dart';
import '../../../Model/store.dart';
import '../../../webview/webview_adidas.dart';
import '../../../webview/webview_amazon.dart';
import '../../../webview/webview_carter.dart';
import '../../../webview/webview_macys.dart';
import '../../../webview/webview_michaelKors.dart';
import '../../../webview/webview_nike.dart';
import '../../../webview/webview_nordstorm.dart';
import '../../../webview/webview_saks.dart';
import '../../../webview/webview_steveMadden.dart';

class HomeScreenGridViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveGridList(
        desiredItemWidth: ScreenUtil().setWidth(90),
        minSpacing: 16,
        scroll: false,
        children: List.generate(StoreModel.storeList().length, (index) {
          final _store = StoreModel.storeList()[index];
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
                /*  Get.to(
                  () => GeneralWebView(
                    url: 'https://www.adidas.com/us',
                    price: 100,
                    webTitle: 'adidas',
                    handleGetPriceFunction: () {},
                  ),
                ); */
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
              height: 100.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: greyColor.withOpacity(0.2),
                    blurRadius: 1,
                    spreadRadius: 0.1,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(
                  _store.storeImage ?? '',
                  scale: 4,
                ),
              ),
            ),
          );
        }));
  }
}
