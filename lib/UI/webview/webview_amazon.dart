import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deal_bazaar/Core/services/local/local_db.dart';
import 'package:deal_bazaar/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:deal_bazaar/UI/shared/navigation_appbar.dart';
import 'package:deal_bazaar/UI/webview/web_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:deal_bazaar/ui/base_view/base_view.dart';
import 'package:web_scraper/web_scraper.dart';

import 'package:webview_flutter/webview_flutter.dart';

import '../../Core/utils/error_dialog.dart';
import '../Screens/SignUp_SignIn_Screens/SignIn_SignUpScreen.dart';
import '../Screens/user_viewmodel/user_viewmodel.dart';

class WebViewAmazon extends StatefulWidget {
  final String url;
  const WebViewAmazon({Key? key, required this.url}) : super(key: key);

  @override
  State<WebViewAmazon> createState() => _WebViewAmazonState();
}

class _WebViewAmazonState extends State<WebViewAmazon> {
  double price = 0;
  String? initialURl;
  getPrice(vm) async {
    _controller!.currentUrl().then((value) async {
      final endpoint = value!.replaceAll(r'https://www.amazon.com', '');

      final webScraper = WebScraper('https://www.amazon.com');
      print("scrped base url");

      print("this is endpoint " + endpoint);
      try {
        if (await webScraper.loadWebPage(endpoint)) {
          print("laoding from endpoint");

          print("scraped product url");

          print("initialized array");
          var val = webScraper.getElement(
              'span.a-price.a-text-price.a-size-medium.apexPriceToPay',
              ['innerHtml']).first['title'];

          var arr = val.split('\$');
          print(arr.last);

          setState(() {
            print("this is price " + arr.last);
            Navigator.pop(context);
            price = double.parse(arr.last);
            showBox(vm);
          });
        }
      } catch (e) {
        setState(() {
          Navigator.pop(context);
          showErrorMessageDialog(
              errorText: "Not a product page", statusText: "400");
        });
      }
    });
  }

  // ignore: prefer_final_fields
  @override
  void initState() {
    setState(() {
      initialURl = widget.url;
    });
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  WebViewController? _controller;
  bool _changeColor = false;

  // final Color _backColor = MarkaColors.black;

  @override
  Widget build(BuildContext context) {
    print("reached here");
    final vm = context.watch<WebViewModel>();
    final _um = context.watch<UserViewModel>();

    return BaseViewWidget(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      avoidScrollView: true,
      fab: Container(
        height: 65,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: MarkaColors.lightGold,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
                onTap: () {
                  _controller!.canGoBack().then((value) {
                    if (value) {
                      _controller?.goBack();
                    }
                  });
                },
                child: Icon(Icons.arrow_back)),
            InkWell(
                // Add TO Wishlist Method

                onTap: () async {
                  LocalDb.checkUserExists().then((value) {
                    if (value) {
                      _controller!.currentUrl().then((value) {
                        log(value!);
                        print(value);
                        vm.showMessageDialog(true,
                            context: context,
                            toExit: true,
                            url: value.toString(),
                            plateform: "amazon");
                      });
                    } else {
                      Get.to(() => SignInSignUpScreen());
                    }
                  });
                },
                child: Icon(Icons.favorite)),
            InkWell(
                onTap: () {
                  _controller?.reload();
                },
                child: Icon(Icons.refresh)),
            InkWell(
                // Add TO Cart Method
                onTap: () async {
                  LocalDb.checkUserExists().then((value) {
                    if (value) {
                      _controller!.currentUrl().then((value) {
                        log(value!);
                        vm.showMessageDialog(false,
                            context: context,
                            toExit: true,
                            url: value.toString(),
                            plateform: "amazon");
                      });
                    } else {
                      Get.to(() => SignInSignUpScreen());
                    }
                  });
                },
                child: Icon(Icons.shopping_cart)),
            InkWell(
                onTap: () {
                  _controller!.canGoForward().then((value) {
                    if (value) {
                      _controller?.goForward();
                    }
                  });
                },
                child: Icon(Icons.arrow_forward)),
          ],
        ),
      ),
      fabLocation: FloatingActionButtonLocation.centerDocked,
      appBar: navigationAppBar2(
          trailingWidget: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Icon(Icons.add)),
          leadingWidget: InkWell(
            onTap: () async {
              await _controller!
                  .clearCache()
                  .whenComplete(() => Get.off(() => HomeScreen()));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
                color: MarkaColors.white,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: MarkaColors.lightGreen,
                ),
              ),
            ),
          ),
          title: 'Deal Bazar',
          textColor: MarkaColors.lightGold),
      body: Stack(
        alignment: Alignment.center,
        children: [
          WebView(
            backgroundColor: _changeColor ? Colors.white : MarkaColors.black,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController cont) {
              log('WebView Created');
              setState(() {
                _controller = cont;
              });
            },
            onPageStarted: (url) {
              log('Page Load Started');
              vm.setWebState(true);
            },
            onPageFinished: (url) {
              log('Page Load Finished');
              vm.setWebState(false);
              vm.setDbId(dbId: _um.user.dbId.toString());
              setState(() {
                _changeColor = true;
              });
            },
            initialUrl: initialURl,
          ),
          Positioned(
            top: 2,
            child: InkWell(
              onTap: () async {
                showLoaderDialog(context, "Getting shipping info..");
                await getPrice(vm);
              },
              child: Container(
                child: Center(
                    child: FittedBox(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "Cost Breakdown",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 35,
                      )
                    ],
                  ),
                )),
                height: 30,
                //    width: 200,
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 205, 234, 236)),
              ),
            ),
          ),
          vm.loadingWebpage
              ? const Center(
                  child: CircularProgressIndicator(
                    color: MarkaColors.gold,
                  ),
                )
              : Stack(),
          if (vm.fetchingInfo)
            Positioned(
              top: BaseViewWidget.width * 0.6,
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text('Fetching Product Information, Wait',
                      style: TextStyle(color: MarkaColors.black)),
                  const SpinKitThreeBounce(
                    color: Colors.black,
                    size: 35.0,
                  ),
                ],
              ),
            ),
          if (vm.savingToDb)
            Positioned(
              top: BaseViewWidget.width * 0.6,
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text('Adding Product',
                      style: TextStyle(color: MarkaColors.black)),
                  const SpinKitThreeBounce(
                    color: Colors.black,
                    size: 35.0,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  showLoaderDialog(BuildContext context, String title) {
    AlertDialog alert = AlertDialog(
      content: FittedBox(
        child: new Row(
          children: [
            CircularProgressIndicator(),
            Container(margin: EdgeInsets.only(left: 7), child: Text(title)),
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showBox(vm) {
    double productPrice = price * 89.5;
    productPrice = double.parse(productPrice.toStringAsFixed(2));
    double plateformFee = (productPrice * 5) / 100;
    plateformFee = double.parse(plateformFee.toStringAsFixed(2));
    double usSalesTax = (productPrice * 9) / 100;
    usSalesTax = double.parse(usSalesTax.toStringAsFixed(2));
    double vat = (productPrice * 12) / 100;
    vat = double.parse(vat.toStringAsFixed(2));
    double shippingCost = 193;
    double total =
        productPrice + plateformFee + usSalesTax + shippingCost + vat;
    total = double.parse(total.toStringAsFixed(2));

    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Builder(
                builder: (context) {
                  // Get available height and width of the build area of this widget. Make a choice depending on the s

                  return Container(
                    height: 450,
                    width: 450,
                    child: Column(children: [
                      Container(
                        height: 30,
                        width: 230,
                        child: Center(
                          child: Text(
                            "Flat Currency Exchange Rate : 89.5TK/1USD",
                            style: TextStyle(fontSize: 9),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 240, 236, 200)),
                      ),
                      Center(child: Text("item information")),
                      SizedBox(
                        height: 10,
                      ),
                      FittedBox(
                        child: Row(
                          children: [
                            Text(
                              "Product Cost",
                              style: TextStyle(fontSize: 10),
                            ),
                            SizedBox(
                              width: 100,
                            ),
                            Text(
                              "${productPrice}Tk",
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.black),
                      FittedBox(
                        child: Row(
                          children: [
                            Text(
                              "5% Plateform Fee",
                              style: TextStyle(fontSize: 10),
                            ),
                            SizedBox(
                              width: 80,
                            ),
                            Text(
                              "${plateformFee}Tk",
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.black),
                      FittedBox(
                        child: Row(
                          children: [
                            Text(
                              "US Sales Tax (9%)",
                              style: TextStyle(fontSize: 10),
                            ),
                            SizedBox(
                              width: 80,
                            ),
                            Text(
                              "${usSalesTax}Tk",
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.black),
                      FittedBox(
                        child: Row(
                          children: [
                            Text(
                              "Shipping & Customs Duty",
                              style: TextStyle(fontSize: 10),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Text(
                              "${shippingCost}Tk",
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.black),
                      FittedBox(
                        child: Row(
                          children: [
                            Text(
                              "Bangladesh VAT (12%)",
                              style: TextStyle(fontSize: 10),
                            ),
                            SizedBox(
                              width: 60,
                            ),
                            Text(
                              "${vat}Tk",
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.black),
                      FittedBox(
                        child: Row(
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 110,
                            ),
                            Text(
                              "${total}Tk",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.black),
                      InkWell(
                        onTap: () {
                          LocalDb.checkUserExists().then((value) {
                            if (value) {
                              LocalDb.getDbID().then((value) async {
                                var collection = FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(value)
                                    .collection("cart");
                                var snapshots = await collection.get();
                                for (var doc in snapshots.docs) {
                                  await doc.reference.delete();
                                }
                              });
                              showLoaderDialog(
                                  context, "Preparing for checkout..");
                              _controller!.currentUrl().then((value) {
                                log(value!);
                                WebViewModel vm = new WebViewModel();
                                vm.showMessageDialog(false,
                                    context: context,
                                    toExit: false,
                                    url: value.toString(),
                                    plateform: "amazon");
                              });
                            } else {
                              Get.to(() => SignInSignUpScreen());
                            }
                          });
                        },
                        child: Container(
                            child: Row(children: [
                              SizedBox(
                                width: 4,
                              ),
                              Icon(Icons.shopping_cart_checkout),
                              SizedBox(
                                width: 4,
                              ),
                              Text("Checkout Now")
                            ]),
                            height: 30,
                            width: 150,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          LocalDb.checkUserExists().then((value) {
                            if (value) {
                              _controller!.currentUrl().then((value) {
                                log(value!);
                                WebViewModel vm = new WebViewModel();
                                vm.showMessageDialog(false,
                                    context: context,
                                    url: value.toString(),
                                    plateform: "carter",
                                    toExit: true);
                              });
                            } else {
                              Get.to(() => SignInSignUpScreen());
                            }
                          });
                        },
                        child: Container(
                            child: Row(children: [
                              SizedBox(
                                width: 4,
                              ),
                              Icon(Icons.shopping_cart),
                              SizedBox(
                                width: 4,
                              ),
                              Text("Add to Cart")
                            ]),
                            height: 30,
                            width: 150,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          LocalDb.checkUserExists().then((value) {
                            if (value) {
                              _controller!.currentUrl().then((value) {
                                log(value!);
                                WebViewModel vm = new WebViewModel();
                                vm.showMessageDialog(false,
                                    context: context,
                                    url: value.toString(),
                                    plateform: "carter",
                                    toExit: true);
                              });
                            } else {
                              Get.to(() => SignInSignUpScreen());
                            }
                          });
                        },
                        child: Container(
                            child: Row(children: [
                              SizedBox(
                                width: 4,
                              ),
                              Icon(Icons.favorite_outline),
                              SizedBox(
                                width: 4,
                              ),
                              Text("Add to Wishlist")
                            ]),
                            height: 30,
                            width: 150,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            child: FittedBox(
                              child: Row(children: [
                                SizedBox(
                                  width: 4,
                                ),
                                Text("Cost Breakdown"),
                                SizedBox(
                                  width: 4,
                                ),
                                Icon(Icons.arrow_drop_up),
                              ]),
                            ),
                            height: 25,
                            width: 153,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                      ),
                    ]),
                  );
                },
              ),
            ));
  }

  showErrorMessageDialog(
      {required String errorText, required String statusText}) {
    print("showing error");
    return Get.dialog(
      ErrorDialog(
        statusText: statusText,
        errorText: errorText,
        buttonText: 'Ok',
        action: () async {
          BaseViewWidget.devLog('Pressed');
          // Get.back();
          Get.back();
          // Navigator.of(context, rootNavigator: true).pop(context);
        },
      ),
    );
  }
}
