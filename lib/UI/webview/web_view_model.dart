import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deal_bazaar/Core/services/local/local_db.dart';
import 'package:deal_bazaar/Core/utils/dialog_button.dart';
import 'package:deal_bazaar/UI/Screens/CartScreen/CheckoutScreen.dart';
import 'package:deal_bazaar/UI/Screens/CartScreen/checkout.dart';
import 'package:deal_bazaar/UI/base_view/base_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:deal_bazaar/core/enums/process_status.dart';
import 'package:deal_bazaar/core/services/database/db_service.dart';
import 'package:deal_bazaar/core/services/shipping/shipping_calculation.dart';
import 'package:deal_bazaar/core/services/web/web_scrap_service.dart';

import 'package:http/http.dart' as http;
import '../../Core/utils/error_dialog.dart';

import '../Screens/roots/root.dart';

import 'package:web_scraper/web_scraper.dart';
import 'package:html/parser.dart' as parser;

class WebViewModel with ChangeNotifier {
  String? _dbId;
  String? _initialUrl;
  String? get initialURL => _initialUrl;

  String? _currentUrl;
  String? get currentURL => _currentUrl;

  String? _previousUrl;
  String? get previousURL => _previousUrl;

  String? _nextUrl;
  String? get nextURL => _nextUrl;

  bool _loadingWebpage = false;
  bool get loadingWebpage => _loadingWebpage;

  bool _fetchingInfo = false;
  bool get fetchingInfo => _fetchingInfo;

  bool _savingToDb = false;
  bool get savingToDb => _savingToDb;

  setDbId({required String dbId}) {
    _dbId = dbId;
    log('Db ID: ' + _dbId.toString());

    notifyListeners();
  }

  setWebState(bool state) {
    _loadingWebpage = state;
    notifyListeners();
  }

  setFetchState(bool state) {
    _fetchingInfo = state;
    notifyListeners();
  }

  setSaveState(bool state) {
    _savingToDb = state;
    notifyListeners();
  }

  updateCurrentUrl(String url) {
    _currentUrl = url;
    notifyListeners();
  }

  updateNextUrl(String url) {
    _nextUrl = url;
    notifyListeners();
  }

  updatePreviousUrl(String url) {
    _previousUrl = url;
    notifyListeners();
  }

  updateInitialUrl(String url) {
    _previousUrl = url;
    notifyListeners();
  }

  setState() {
    notifyListeners();
  }

  makeServerRequest(bool isWishlist,
      {required String url,
      required BuildContext context,
      required bool toExit}) async {
    print("making several requests");

    setFetchState(true);
    try {
      await WebScrapService.getProductDetails(url: url).then((response) async {
        print("now im here");
        if (response.status == ProcessStatus.compeleted) {
          final ProductModel product = response.value['data'];
          final itemWeight = ShippingCalculation.getItemWeight(product);
          product.productWeight = itemWeight;
          print("good");
          final rWeight =
              ShippingCalculation.findRealWeight(itemWeight.toString());
          print("ok");
          final dims = ShippingCalculation.getProductDimensions(product);
          print("perfect");
          product.productDimensions = dims;
          final rDims = ShippingCalculation.findDimensions(dims.toString());
          print("just ok");
          final dWeight = ShippingCalculation.findDimWeight(rDims);
          product.dimensionalWeight = dWeight.toString();
          print("all well");

          final fWeight = ShippingCalculation.findFinalWeight(rWeight, dWeight);
          product.finalWeight = fWeight.toString();
          print("about to cplt");
          final SC = ShippingCalculation.totalShippingCost(fWeight);
          product.shippingCost = SC;
          print("completed");
          log(product.title.toString());
          setFetchState(false);
          setSaveState(true);
          isWishlist
              ? await _addToWishlist(product: product)
              : await _addToCart(
                  product: product, toExit: toExit, context: context);

          Get.back();
        } else if (response.status == ProcessStatus.failed) {
          if (!toExit) {
            Navigator.pop(context);
          }
          log(response.value['code']);
          log(response.value['error']);

          setFetchState(false);

          await showErrorMessageDialog(
              errorText: response.value['error'],
              statusText: response.value['code']);
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  makeServerRequestAdidas(bool isWishlist,
      {required String url,
      required BuildContext context,
      required bool toExit}) async {
    setFetchState(true);

    print(url);
    print("in adidas");
    var client = http.Client();
    final encoded = Uri.encodeComponent(url);
    try {
      String Url =
          "https://api.proxycrawl.com/scraper?token=FvDuXxv8GZYgDxQ0eJi-Zw&format=json&url=${url}";
      await client
          .get(
        Uri.parse(
          Url,
        ),
      )
          .then((value) async {
        ProductModel product = new ProductModel();
        print("inside then");
        product.brand = "Adidas";
        print(jsonDecode(value.body));
        final data = jsonDecode(value.body);

        product.title = data['body']['title'];
        product.description = data['body']['meta']['description'];
        product.productInfo = [data['body']['content']];
        print("fetching details");
        product.images = data['body']['images'];

        product.mainImage = data['body']['images'].first;
        print("fetched");
        product.isAvailable = true;
        product.quantity = 1;
        product.reviews = "0 reviews";
        product.customerReviewCount = 0;
        product.seller = "Adidas.com";
        product.shippingFirm = "Adidas.com";
        final endpoint = url.replaceAll(r'https://www.adidas.com', '');
        print("replaced url");
        print(endpoint);
        final webScraper = WebScraper('https://www.adidas.com');
        print("base done");
        print("scrped base url");

        print("this is endpoint " + endpoint);
        if (await webScraper.loadWebPage(endpoint)) {
          print("scraped product url");
          print("initialized array");
          var price = webScraper.getElement(
              'div.gl-price-item.notranslate', ['innerHtml']).first['title'];
          String val = price.replaceAll(r'₹', '');
          val = price.replaceAll(r'$', '');

          print(val);
          product.price = "\$" + val;
          print("ok");
          setFetchState(false);
          setSaveState(true);
          isWishlist
              ? await _addToWishlist(product: product)
              : await _addToCart(
                  product: product, toExit: toExit, context: context);
          setSaveState(false);
          Get.back();
        }
      });
    } catch (e) {
      print(e.toString());
      setFetchState(false);
      if (!toExit) {
        Navigator.pop(context);
      }
      await showErrorMessageDialog(
          errorText: "Not product page", statusText: "400");
    }
  }

  makeServerRequestMichaelKors(bool isWishlist,
      {required String url,
      required BuildContext context,
      required bool toExit}) async {
    print(url);
    print("in michael kors");
    var client = http.Client();
    try {
      String apiKey = "e9367aa4217132241e1d0fce7191d7ba";
      final encoded = Uri.encodeComponent(url);
      setFetchState(true);
      String Url =
          "https://api.proxycrawl.com/scraper?token=FvDuXxv8GZYgDxQ0eJi-Zw&format=json&url=${url}";
      await client
          .get(
        Uri.parse(
          Url,
        ),
      )
          .then((value) async {
        ProductModel product = new ProductModel();
        print(value.body);
        var data = jsonDecode(value.body);
        product.brand = "MichaelKors";
        product.title = data['body']['title'];
        product.description = data['body']['meta']['description'];
        product.productInfo = [data['body']['content']];
        product.images = data['body']['images'];
        product.mainImage = data['body']['canonical'];
        product.isAvailable = true;
        product.quantity = 1;
        product.reviews = "0 reviews";
        product.customerReviewCount = 0;
        product.seller = "MichaelKors";
        product.shippingFirm = "MichaelKors.global";

        print("replacing url");

        final endpoint = url.replaceAll(r'https://www.michaelkors.com', '');

        final webScraper = WebScraper('https://www.michaelkors.com');
        print("scrped base url");

        print("this is endpoint " + endpoint);
        final encoded = Uri.encodeComponent(endpoint);
        print(encoded);
        try {
          if (await webScraper.loadWebPage(endpoint)) {
            print("scraped product url");

            print("initialized array");
            var val = webScraper.getElement('span.ada-link.productAmount',
                    ['innerHtml']).first['title'] ??
                "\$0";

            product.price = val;
            product.originalPrice = val;

            setFetchState(false);
            setSaveState(true);
            isWishlist
                ? await _addToWishlist(product: product)
                : await _addToCart(
                    product: product, toExit: toExit, context: context);
            setSaveState(false);
            Get.back();
          }
        } catch (e) {
          product.price = '\$0';
          print(e.toString());
          setFetchState(false);
          setSaveState(true);
          isWishlist
              ? await _addToWishlist(product: product)
              : await _addToCart(
                  product: product, toExit: toExit, context: context);
          setSaveState(false);
          Get.back();
        }
      });
    } catch (e) {
      if (!toExit) {
        Navigator.pop(context);
      }
      setFetchState(false);
      await showErrorMessageDialog(
          errorText: "Not product page", statusText: "400");
    }
  }

  makeServerRequestSaks(bool isWishlist,
      {required String url,
      required BuildContext context,
      required bool toExit}) async {
    print(url);
    print("in saks");
    setFetchState(true);
    var client = http.Client();
    try {
      setFetchState(true);
      String Url =
          "https://api.proxycrawl.com/scraper?token=FvDuXxv8GZYgDxQ0eJi-Zw&format=json&url=${url}";
      await client
          .get(
        Uri.parse(
          Url,
        ),
      )
          .then((value) async {
        ProductModel product = new ProductModel();
        print("this is body...");
        print(value.body);
        product.brand = 'SalksFifthAvenue';
        var data = jsonDecode(value.body);
        product.title = data['body']['title'];
        product.description = data['body']['meta']['description'];
        product.productUrl = url;
        product.mainImage = data['body']['images'].first;
        product.images = data['body']['images'];
        product.isAvailable = true;
        product.quantity = 1;
        product.reviews = "0 reviews";
        product.customerReviewCount = 0;
        product.seller = "SalksFifthAvenue.com";
        product.shippingFirm = "SalksFifthAvenue.com";
        print("replacing url");
        final endpoint = url.replaceAll(r'https://www.saksfifthavenue.com', '');

        final webScraper = WebScraper('https://www.saksfifthavenue.com');
        print("scrped base url");

        print("this is endpoint " + endpoint);
        final encoded = Uri.encodeComponent(endpoint);
        print(encoded);
        if (await webScraper.loadWebPage(endpoint)) {
          print("scraped product url");

          print("initialized array");
          var val = webScraper.getElement(
              'span.formatted_sale_price.formatted_price.js-final-sale-price.bfx-price.bfx-list-price',
              ['innerHtml']).first['title'];

          product.price = val;
          product.originalPrice = val;

          setFetchState(false);
          setSaveState(true);
          isWishlist
              ? await _addToWishlist(product: product)
              : await _addToCart(
                  product: product, toExit: toExit, context: context);
          setSaveState(false);
          Get.back();
          print(value.reasonPhrase);
        }
      });
    } catch (e) {
      if (!toExit) {
        Navigator.pop(context);
      }
      setFetchState(false);
      await showErrorMessageDialog(
          errorText: "Not product page", statusText: "400");
    }
  }

  makeServerRequestNike(bool isWishlist,
      {required String url,
      required BuildContext context,
      required bool toExit}) async {
    print(url);
    print("in nike");
    setFetchState(true);
    var client = http.Client();
    try {
      String apiKey = "e9367aa4217132241e1d0fce7191d7ba";
      final encoded = Uri.encodeComponent(url);
      setFetchState(true);
      String Url =
          "https://api.proxycrawl.com/scraper?token=FvDuXxv8GZYgDxQ0eJi-Zw&format=json&url=${url}";
      await client
          .get(
        Uri.parse(
          Url,
        ),
      )
          .then((value) async {
        ProductModel product = new ProductModel();
        print("this is body");
        log(value.body);
        product.brand = 'Nike';
        var data = jsonDecode(value.body);
        product.title = data['body']['title'];
        product.description = data['body']['meta']['description'];
        product.productUrl = url;
        product.mainImage = data['body']['images'].last;
        product.images = data['body']['images'];
        product.isAvailable = true;
        product.quantity = 1;

        product.reviews = "0 reviews";
        product.customerReviewCount = 0;
        product.seller = "Nike.com";
        product.shippingFirm = "Nike.com";
        print("replacing url");
        final endpoint = url.replaceAll(r'https://www.nike.com', '');

        final webScraper = WebScraper('https://www.nike.com');
        print("scrped base url");

        print("this is endpoint " + endpoint);
        final encoded = Uri.encodeComponent(endpoint);
        print(encoded);
        if (await webScraper.loadWebPage(endpoint)) {
          print("scraped product url");

          print("initialized array");
          var val = webScraper.getElement(
              'div.product-price.css-11s12ax.is--current-price.css-tpaepq',
              ['innerHtml']).first['title'];

          product.price = val;
          product.originalPrice = val;
          print(val);

          setFetchState(false);
          setSaveState(true);
          isWishlist
              ? await _addToWishlist(product: product)
              : await _addToCart(
                  product: product, toExit: toExit, context: context);
          setSaveState(false);
          Get.back();
          print(value.reasonPhrase);
        }
      });
    } catch (e) {
      if (!toExit) {
        Navigator.pop(context);
      }
      setFetchState(false);
      await showErrorMessageDialog(
          errorText: "Not product page", statusText: "400");
    }
  }

  makeServerRequestMacys(bool isWishlist,
      {required String url,
      required BuildContext context,
      required bool toExit}) async {
    print(url);
    print("in macy");
    setFetchState(true);
    var client = http.Client();
    try {
      String apiKey = "e9367aa4217132241e1d0fce7191d7ba";
      final encoded = Uri.encodeComponent(url);
      setFetchState(true);
      String Url =
          "https://api.proxycrawl.com/scraper?token=FvDuXxv8GZYgDxQ0eJi-Zw&format=json&url=${url}";
      await client
          .get(
        Uri.parse(
          Url,
        ),
      )
          .then((value) async {
        ProductModel product = new ProductModel();
        print(value.body);
        product.brand = "Macys";
        var data = jsonDecode(value.body);
        product.title = data['body']['title'];
        product.description = data['body']['meta']['description'];
        product.productUrl = url;
        product.mainImage = data['body']['og_images'].first;
        product.images = data['body']['images'] ?? [];
        product.isAvailable = true;
        product.quantity = 1;

        product.reviews = "0 reviews";
        product.customerReviewCount = 0;
        product.seller = "Macys.com";
        product.shippingFirm = "Macys.com";
        print("replacing url");
        final endpoint = url.replaceAll(r'https://www.macys.com', '');

        final webScraper = WebScraper('https://www.macys.com');
        print("scrped base url");

        print("this is endpoint " + endpoint);
        final encoded = Uri.encodeComponent(endpoint);
        print("try");
        try {
          if (await webScraper.loadWebPage(endpoint)) {
            print("scraped product url");

            print("initialized array");
            var val = webScraper
                .getElement('span.bold.c-red', ['innerHtml']).first['title'];

            product.price = val;
            product.originalPrice = val;
            print(val);

            setFetchState(false);
            setSaveState(true);
            isWishlist
                ? await _addToWishlist(product: product)
                : await _addToCart(
                    product: product, toExit: toExit, context: context);
            setSaveState(false);
            Get.back();
          }
        } catch (e) {
          product.price = '\$0';
          setFetchState(false);
          setSaveState(true);
          isWishlist
              ? await _addToWishlist(product: product)
              : await _addToCart(
                  product: product, toExit: toExit, context: context);
          setSaveState(false);
          Get.back();
        }
      });
    } catch (e) {
      if (!toExit) {
        Navigator.pop(context);
      }
      setFetchState(false);
      await showErrorMessageDialog(
          errorText: "Not product page", statusText: "400");
    }
  }

  makeServerRequestSteveMadden(bool isWishlist,
      {required String url,
      required BuildContext context,
      required bool toExit}) async {
    print(url);
    print("in steve madden");
    setFetchState(true);
    var client = http.Client();
    try {
      String apiKey = "e9367aa4217132241e1d0fce7191d7ba";
      final encoded = Uri.encodeComponent(url);
      setFetchState(true);
      String Url =
          "https://api.proxycrawl.com/scraper?token=FvDuXxv8GZYgDxQ0eJi-Zw&format=json&url=${url}";
      await client
          .get(
        Uri.parse(
          Url,
        ),
      )
          .then((value) async {
        ProductModel product = new ProductModel();
        print("this s body");
        print(value.body);
        product.brand = "SteveMadden";
        var data = jsonDecode(value.body);
        product.title = data['body']['title'];
        product.description = data['body']['meta']['description'];
        product.productUrl = url;
        product.mainImage = data['body']['og_images'].first;
        product.images = data['body']['images'];
        product.isAvailable = true;
        product.quantity = 1;

        product.reviews = "0 reviews";
        product.customerReviewCount = 0;
        product.seller = "SteveMadden.com";
        product.shippingFirm = "SteveMadden.com";
        print("replacing url");
        final endpoint = url.replaceAll(r'https://www.stevemadden.com', '');

        final webScraper = WebScraper('https://www.stevemadden.com');
        print("scrped base url");

        print("this is endpoint " + endpoint);
        final encoded = Uri.encodeComponent(endpoint);
        print(encoded);
        if (await webScraper.loadWebPage(endpoint)) {
          print("scraped product url");

          print("initialized array");
          var val =
              webScraper.getElement('h3.price', ['innerHtml']).first['title'];
          print(val);

          product.price = val;
          product.originalPrice = val;

          setFetchState(false);
          setSaveState(true);
          isWishlist
              ? await _addToWishlist(product: product)
              : await _addToCart(
                  product: product, toExit: toExit, context: context);
          setSaveState(false);
          Get.back();
        }
      });
    } catch (e) {
      if (!toExit) {
        Navigator.pop(context);
      }
      setFetchState(false);
      await showErrorMessageDialog(
          errorText: "Not product page", statusText: "400");
    }
  }

  makeServerRequestCarter(bool isWishlist,
      {required String url,
      required BuildContext context,
      required bool toExit}) async {
    print(url);
    print("in carter");
    setFetchState(true);
    var client = http.Client();
    try {
      String apiKey = "e9367aa4217132241e1d0fce7191d7ba";
      final encoded = Uri.encodeComponent(url);
      setFetchState(true);
      String Url =
          "https://api.proxycrawl.com/scraper?token=FvDuXxv8GZYgDxQ0eJi-Zw&format=json&url=${url}";
      await client
          .get(
        Uri.parse(
          Url,
        ),
      )
          .then((value) async {
        ProductModel product = new ProductModel();
        log(value.body);
        product.brand = "Carter's";
        var data = jsonDecode(value.body);
        product.title = data['body']['title'];
        product.description = data['body']['meta']['description'];
        product.productUrl = url;
        product.mainImage = data['body']['og_images'].first;
        product.images = data['body']['images'];
        product.isAvailable = true;
        product.quantity = 1;

        product.reviews = "0 reviews";
        product.customerReviewCount = 0;
        product.seller = "Carter's.com";
        product.shippingFirm = "Carter's.com";
        print("replacing url");
        final endpoint = url.replaceAll(r'https://www.carters.com', '');

        final webScraper = WebScraper('https://www.carters.com');
        print("scrped base url");

        print("this is endpoint " + endpoint);

        if (await webScraper.loadWebPage(endpoint)) {
          print("laoding from endpoint");

          print("scraped product url");

          print("initialized array");
          var val = webScraper
                  .getElement('span.value', ['innerHtml']).first['title'] ??
              "\$0";
          print(val);

          product.price = val;
          product.originalPrice = val;

          setFetchState(false);
          setSaveState(true);
          isWishlist
              ? await _addToWishlist(product: product)
              : await _addToCart(
                  product: product, toExit: toExit, context: context);
        }
      });
    } catch (e) {
      if (!toExit) {
        Navigator.pop(context);
      }
      print("some exception");
      print(e.toString());
      setFetchState(false);
      await showErrorMessageDialog(
          errorText: "Not product page", statusText: "400");
    }
  }

  makeServerRequestNord(bool isWishlist,
      {required String url, required BuildContext context}) async {
    //Status Code 200 means response has been received successfully

    //Getting the html document from the response

    try {
      print("parsed");
      //Scraping the first article title
      print("replacing url");
      final endpoint = url.replaceAll(r'https://www.nordstrom.com', '');

      final webScraper = WebScraper('https://www.nordstrom.com');
      print("scrped base url");

      print("this is endpoint " + endpoint);
      final encoded = Uri.encodeComponent(endpoint);
      print(encoded);
      if (await webScraper.loadWebPage(endpoint)) {
        print("scraped product url");

        print("initialized array");
        var val = webScraper
            .getElement('h1._39r2W.gFaKF._3jNIn._36liS', ['innerHtml']);
        print(val);
      }

      //Scraping the second article title

    } catch (e) {
      setFetchState(false);
      await showErrorMessageDialog(
          errorText: "Not product page", statusText: "400");
    }
  }

  showMessageDialog(bool isWishlist,
      {required BuildContext context,
      required bool toExit,
      required String url,
      required String plateform}) {
    print("showing dialogue");
    final str = isWishlist ? 'Wishlist' : 'Cart';
    return showDialog(
        // barrierDismissible: false,
        context: context,
        builder: (context) {
          return DialogButton(
            titleText: toExit
                ? 'Before adding to $str, make sure to be on the product page'
                : 'Before purchasing, make sure to be on the product page',
            buttonText: 'Yes I\'m',
            action: () async {
              BaseViewWidget.devLog('Pressed');
              // Get.back();
              Navigator.of(context, rootNavigator: true).pop(context);

              if (plateform == 'amazon') {
                await makeServerRequest(isWishlist,
                    url: url, context: context, toExit: toExit);
              }
              if (plateform == 'adidas') {
                await makeServerRequestAdidas(isWishlist,
                    url: url, context: context, toExit: toExit);
              }
              if (plateform == 'michaelkors') {
                await makeServerRequestMichaelKors(isWishlist,
                    url: url, context: context, toExit: toExit);
              }
              if (plateform == 'saks') {
                await makeServerRequestSaks(isWishlist,
                    url: url, context: context, toExit: toExit);
              }
              if (plateform == 'nike') {
                await makeServerRequestNike(isWishlist,
                    url: url, context: context, toExit: toExit);
              }
              if (plateform == 'macys') {
                await makeServerRequestMacys(isWishlist,
                    url: url, context: context, toExit: toExit);
              }
              if (plateform == 'carter') {
                await makeServerRequestCarter(isWishlist,
                    url: url, context: context, toExit: toExit);
              }
              if (plateform == 'stevemadden') {
                await makeServerRequestSteveMadden(isWishlist,
                    url: url, context: context, toExit: toExit);
              }
              if (plateform == 'nord') {
                await makeServerRequestNord(isWishlist,
                    url: url, context: context);
              }
              // Get.off(() => const SignUpView()); // Get.offAll();
            },
          );
        });
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

  _addToCart(
      {required ProductModel product,
      required bool toExit,
      required BuildContext context}) async {
    print("adding to cart");
    print("IN CART");
    FirebaseAuth user = FirebaseAuth.instance;
    print(user.currentUser!.uid);
    await DbService()
        .addProductToCart(dbId: user.currentUser!.uid, product: product)
        .then((response) {
      print("this is response");
      print(response.status);
      if (response.status != ProcessStatus.failed) {
        setSaveState(false);
        print("response successfull");
        Get.snackbar('Product Added to Cart Succesfully', '',
            backgroundColor: MarkaColors.gold,
            colorText: MarkaColors.white,
            duration: const Duration(seconds: 5),
            snackPosition: SnackPosition.BOTTOM);

        try {
          if (toExit) {
            Get.offAll(() => const Root());
          } else {
            print("reached here");
            LocalDb.getDbID().then((value) {
              print(value);
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(value)
                  .collection('cart')
                  .get()
                  .then((value) {
                print("this is size " + value.size.toString());
                ProductModel productModel = new ProductModel();
                productModel.mainImage = value.docs[0].get("mainImage");
                productModel.price = value.docs[0].get("price");
                productModel.title = value.docs[0].get("title");
                productModel.quantity = value.docs[0].get("quantity");
                List<ProductModel> cartProducts = [productModel];
                Get.to(Checkout(product: cartProducts));
              });
            });
          }
        } catch (e) {
          print("some error");
        }
      } else if (response.status == ProcessStatus.failed) {
        setSaveState(false);
        print("response failed");
        Get.snackbar('Operation Failed', '${response.value['error']}',
            backgroundColor: MarkaColors.gold,
            colorText: MarkaColors.white,
            duration: const Duration(seconds: 5),
            snackPosition: SnackPosition.BOTTOM);
      }
    });
  }

  getAllCartProducts(QuerySnapshot snapshot) {
    List<ProductModel> cartProducts = [];
    if (snapshot.docs.isNotEmpty) {
      for (var element in snapshot.docs) {
        cartProducts.add(ProductModel.fromFirebase(firebase: element));
      }
    }
    Get.to(CheckoutScreen(product: cartProducts));
  }

  _addToWishlist({required ProductModel product}) async {
    print("adding to wishlists");
    await DbService()
        .addProductToWishList(dbId: _dbId!, product: product)
        .then((response) {
      if (response.status == ProcessStatus.compeleted) {
        setSaveState(false);

        Get.snackbar('Product Added to Wishlist Succesfully', '',
            backgroundColor: MarkaColors.gold,
            colorText: MarkaColors.white,
            duration: const Duration(seconds: 5),
            snackPosition: SnackPosition.BOTTOM);
        Get.offAll(() => const Root());
      } else if (response.status == ProcessStatus.failed) {
        setSaveState(false);

        Get.snackbar('Operation Failed', '${response.value['error']}',
            backgroundColor: MarkaColors.gold,
            colorText: MarkaColors.white,
            duration: const Duration(seconds: 5),
            snackPosition: SnackPosition.BOTTOM);
      }
    });
  }
}
