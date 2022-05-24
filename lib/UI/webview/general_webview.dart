import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deal_bazaar/UI/shared/appbar.dart';
import 'package:deal_bazaar/UI/webview/web_view_model.dart';
import 'package:deal_bazaar/UI/webview/widgets/web_leading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../Core/services/local/local_db.dart';
import '../../Core/utils/error_dialog.dart';
import '../../ui/base_view/base_view.dart';
import '../Screens/HomeScreen/HomeScreen.dart';
import '../Screens/SignUp_SignIn_Screens/SignIn_SignUpScreen.dart';
import '../Screens/user_viewmodel/user_viewmodel.dart';
import 'widgets/web_bottom_nav.dart';

class GeneralWebView extends StatefulWidget {
  final String? webTitle;
  final String? url;
  final double price;
  final Function(String url)? handleGetPriceFunction;

  const GeneralWebView(
      {required this.url,
      required this.handleGetPriceFunction,
      required this.price,
      this.webTitle = '',
      Key? key})
      : super(key: key);

  @override
  State<GeneralWebView> createState() => _GeneralWebViewState();
}

class _GeneralWebViewState extends State<GeneralWebView> {
  String? _initialUrl;
  WebViewController? _controller;
  double _price = 0;

  @override
  void initState() {
    _initialUrl = widget.url;
    _price = widget.price;
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
  }

  Future<void> _getPrice(vm) async {
    _controller!.currentUrl().then((value) async {
      widget.handleGetPriceFunction!(value ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<WebViewModel>();
    final _um = context.watch<UserViewModel>();

    return Scaffold(
      appBar: defaultAppBar(context,
          leadingWidget: LeadingWidget(
            onTap: () async => await _controller!
                .clearCache()
                .whenComplete(() => Get.off(() => HomeScreen())),
          )),
      bottomNavigationBar: WebBottomNav(onTap: (index) => _tapped(index, vm)),
      body: Stack(
        alignment: Alignment.center,
        children: [
          WebView(
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
            },
            initialUrl: _initialUrl,
          ),
          Positioned(
            top: 2,
            child: InkWell(
              onTap: () async {
                // showLoaderDialog(context, 'Getting shipping info..');
                await _getPrice(vm);
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
                //       width: 200,
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

  void _tapped(int index, WebViewModel? vm) {
    switch (index) {
      case 0:
        _goBack();
        break;
      case 1:
        _addToWishList(vm);
        break;
      case 2:
        _refresh();
        break;
      case 3:
        _addToCart(vm);
        break;
      case 4:
        _goForward();
        break;
      default:
    }
  }

  void _goBack() => _controller!.canGoBack().then((value) {
        if (value) {
          _controller?.goBack();
        }
      });

  void _refresh() async => await _controller?.reload();

  void _addToWishList(WebViewModel? vm) =>
      LocalDb.checkUserExists().then((value) {
        if (value) {
          _controller!.currentUrl().then((value) {
            log(value!);
            vm?.showMessageDialog(true,
                context: context,
                toExit: true,
                url: value.toString(),
                plateform: _initialUrl ?? '');
          });
        } else {
          Get.to(() => SignInSignUpScreen());
        }
      });
  void _addToCart(WebViewModel? vm) => LocalDb.checkUserExists().then((value) {
        if (value) {
          _controller!.currentUrl().then((value) {
            log(value!);
            vm?.showMessageDialog(false,
                context: context,
                toExit: true,
                url: value.toString(),
                plateform: "michaelkors");
          });
        } else {
          Get.to(() => SignInSignUpScreen());
        }
      });

  void _goForward() => _controller!.canGoForward().then((value) {
        if (value) {
          _controller?.goForward();
        }
      });

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
    double productPrice = _price * 89.5;
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
                                    plateform: "michaelkors");
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
