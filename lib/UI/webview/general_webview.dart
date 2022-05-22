import 'dart:io';

import 'package:deal_bazaar/UI/shared/appbar.dart';
import 'package:deal_bazaar/UI/webview/web_view_model.dart';
import 'package:deal_bazaar/UI/webview/widgets/web_leading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../Core/services/local/local_db.dart';
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
}
