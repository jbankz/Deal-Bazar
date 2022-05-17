// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:math' as math;

import 'package:deal_bazaar/Core/utils/error_dialog.dart';
import 'package:deal_bazaar/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:deal_bazaar/UI/base_view/base_view.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/intl.dart';
import 'package:deal_bazaar/Core/enums/process_status.dart';
import 'package:deal_bazaar/core/services/database/db_service.dart';
import 'package:deal_bazaar/core/services/shipping/shipping_calculation.dart';
import 'package:deal_bazaar/marka_imports.dart';

import 'package:random_string_generator/random_string_generator.dart';

import 'dialog_button_2.dart';

class CartViewModel with ChangeNotifier {
  Map<String, dynamic>? _paymentIntentData;

  int? _dimensionsIndex;
  int? _weightIndex;
  int? get dimensionsIndex => _dimensionsIndex;
  int? get weightIndex => _weightIndex;

  /// [CheckoutParameters]
  // ignore: prefer_final_fields
  List<double> _productPrices = [];
  List<double> _shppingPrices = [];

  reinitialize() {
    _productPrices.clear();
    _shppingPrices.clear();

    notifyListeners();
  }

  double? _customCharges;
  double? get customeCharges => _customCharges;

  double? _delieveryCharges;
  double? get delieveryCharges => _delieveryCharges;

  double _grandTotal = 0;
  double? get grandTotal => _grandTotal;

  List<double> get productPrices => _productPrices;

  String? _trackingId;

  String? get trackingId => _trackingId;

  setDimensionsAndWeightIndex(int? dimInd, int? weightInd) {
    _dimensionsIndex = dimInd;
    _weightIndex = weightInd;
    notifyListeners();
  }

  String? getProductDimensions(ProductModel product) {
    String? retVal;
    for (var k = 0; k < product.productInfo!.length; k++) {
      final val = product.productInfo![k];
      final r = val['name'];
      final res = r.contains(RegExp('[a-zA-Z]+ Dimensions'));
      if (res == true) {
        retVal = val['value'];
        break;
      }
    }
    return retVal;
  }

  String? getItemWeight(ProductModel product) {
    String? retVal;
    for (var k = 0; k < product.productInfo!.length; k++) {
      final val = product.productInfo![k];
      final r = val['name'];
      final res = r.contains(RegExp('[a-zA-Z]+ Weight'));
      if (res == true) {
        retVal = val['value'];
        break;
      }
    }
    return retVal;
  }

// / Final Checkout Methods

  generateTrackingId() async {
    var generator = RandomStringGenerator(
      hasAlpha: true,
      alphaCase: AlphaCase.UPPERCASE_ONLY,
      hasDigits: true,
      hasSymbols: false,
      minLength: 5,
      maxLength: 7,
    );

    try {
      _trackingId = generator.generate();
    } on RandomStringGeneratorException catch (e) {
      log(e.message);
    }

    notifyListeners();
  }

  clearProductPrices() {
    _productPrices.clear();
    notifyListeners();
  }

  calculateCustomCostWithQuantity({required List<ProductModel> products}) {
    _customCharges = products.length * 1.12;

    notifyListeners();
  }

  calculateDeliveryCostWithQuantity({int? length}) {
    _delieveryCharges = length! * 193.50;

    notifyListeners();
  }

  calculateSCWithQuantity({required int quantity, required double price}) {
    print("here is the price " + price.toString());
    _grandTotal = _grandTotal + price;
    _shppingPrices.add(quantity * price);
    notifyListeners();
    log(_shppingPrices.first.toString());
    // return (quantity * double.parse(price));
  }

  calculatePriceWithQuantity({required int quantity, required String price}) {
    price = price.replaceAll(RegExp(r'\$'), '');
    price = price.replaceAll(RegExp(r','), '');

    _productPrices.add(quantity * double.parse(price));
    notifyListeners();
    log(_productPrices.first.toString());
    // return (quantity * double.parse(price));
  }

  showErrorMessageDialog(
      {required String errorText, required String statusText}) {
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

  /// [LoadingStates]
// ignore: prefer_final_fields
  bool _placingOrder = false;
  bool get placingOrder => _placingOrder;

  _finalizeOrder(
      {required List<ProductModel> finalProducts, required String dbId}) async {
    _placingOrder = true;
    notifyListeners();
    List<Map<String, dynamic>> _products = [];

    for (var product in finalProducts) {
      _products.add(product.toFirebase());
    }
    // _products.add(widget.product.first.toFirebase());
    // _products.add(widget.product[1].toFirebase());

    OrderStatusModel _order = OrderStatusModel(products: _products);
    var generator = RandomStringGenerator(
      hasDigits: true,
      hasSymbols: false,
      minLength: 8,
      maxLength: 10,
    );

    try {
      _order.orderId = generator.generate();
    } on RandomStringGeneratorException catch (e) {
      log(e.message);
    }

    _order.date = DateFormat.yMEd().add_jms().format(DateTime.now());
    _order.isDelievered = false;
    _order.isDelieveredToShippingPoints = false;
    _order.isFeedback = false;
    _order.isFinalized = false;
    _order.isShippingStarted = false;
    _order.trackingId = _trackingId;
    _order.price = _grandTotal;

    await DbService()
        .placeOrder(order: _order, dbId: dbId, products: finalProducts)
        .then((value) {
      if (value == ProcessStatus.compeleted) {
        _placingOrder = false;
        notifyListeners();

        Get.dialog(DialogButton2(
          titleText: 'Success',
          middleText:
              'Your order has been Placed & will deliver soon Thank you for shopping. Have a great time',
          buttonText: 'DONE',
          action: () {
            BaseViewWidget.devLog('Pressed');
            // Get.back();
            Get.back();
            Get.offAll(() => HomeScreen()); // Get.offAll();
          },
        ));
      } else if (value == ProcessStatus.failed) {
        _placingOrder = false;
        notifyListeners();

        showErrorMessageDialog(
            errorText: 'Processing Error',
            statusText: 'Payment Process Failed');
      }
    });
  }

  /// [PaymentMethods]
  ///
  Future<void> makePayment(
      {required List<ProductModel> finalProducts, required String dbId}) async {
    try {
      _paymentIntentData = await _createPaymentIntent(
          amount: _grandTotal.toStringAsFixed(0), currency: 'USD');

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret:
            'pk_test_51KNaoPDbwWjt103ysexLeLE9WHPA3T9pTrYpOcbrOeeUniuSTbQlXirGyDqof4AKoYsK13Whi5rXsYUeTek9s4KZ00O9DC3jSf',
        applePay: true,
        googlePay: true,
        merchantCountryCode: 'US',
        merchantDisplayName: 'DealBazar',
        style: ThemeMode.dark,
      ));

      _displayPaymentSheet(
        finalProducts: finalProducts,
        dbId: dbId,
      );
    } catch (e) {
      log('Exception: ' + e.toString());
    }
  }

  _displayPaymentSheet(
      {required List<ProductModel> finalProducts, required String dbId}) async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
              parameters: PresentPaymentSheetParameters(
        clientSecret: _paymentIntentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) async {
        //orderPlaceApi(paymentIntentData!['id'].toString());

        //  Get.snackbar('Payment Successfull', '',
        //     backgroundColor: MarkaColors.gold,
        //     colorText: MarkaColors.white,
        //     duration: const Duration(seconds: 5),
        //     snackPosition: SnackPosition.BOTTOM);
        await _finalizeOrder(finalProducts: finalProducts, dbId: dbId);

        _paymentIntentData?.clear();
      }).onError((error, stackTrace) {
        log('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      log('Exception/DISPLAYPAYMENTSHEET==> $e');
      Get.dialog(const Text("Cancelled "));
    } catch (e) {
      log('$e');
    }
  }

  _createPaymentIntent(
      {required String amount, required String currency}) async {
    try {
      Map<String, dynamic> body = {
        'amount': _calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51KNaoPDbwWjt103yeJw6GbYwUXYHRDhyNjtXjnYmFiJ4tHtBlNypTolOU57PnKLvWp2RMSD25OErHFWnRccRW12R00Q18iY5F8',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body.toString());
    } catch (e) {
      log('Exception: ' + e.toString());
    }
  }

  _calculateAmount(String amount) {
    final price = int.parse(amount) * 100;
    return price.toString();
  }
}
