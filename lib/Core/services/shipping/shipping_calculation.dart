// ignore_for_file: avoid_print

import 'package:deal_bazaar/marka_imports.dart';

class ShippingCalculation {
  static const shipCostPound = 8.50;
  static const dimFactor = 139;
  static const customCost = 0.05;
  static const homeDelieveryFee = 6.70;
  static const markaFee = 0.05;

  static String? getItemWeight(ProductModel product) {
    String? retVal;
    for (var k = 0; k < product.productInfo!.length; k++) {
      final val = product.productInfo![k];
      final r = val['name'];
      final res = r.contains(RegExp('[a-zA-Z]+ Weight'));
      if (res == true) {
        retVal = val['value'] ?? '0 ounces';
        break;
      }
    }
    return retVal;
  }

  static String? getProductDimensions(ProductModel product) {
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

  static double findRealWeight(String itemWeight) {
    print("weight " + itemWeight);
    itemWeight = itemWeight.replaceAll('pounds', '');
    itemWeight = itemWeight.replaceAll('ounces', '');
    itemWeight = itemWeight.replaceAll('Pounds', '');
    itemWeight = itemWeight.replaceAll('Ounces', '');
    itemWeight = itemWeight.trim();

    return double.parse(itemWeight);
  }

  static List<String> findDimensions(String data) {
    final v = data.split(" ");
    v.removeWhere((item) => item == 'x' || item == 'inches');

    return v;
  }

  static double findDimWeight(List<String> dim) {
    double f1 = 0.4;

    double f2 = 0.2;
    double f3 = 0.1;

    try {
      f1 = double.parse(dim[0].trim());
      // ignore: avoid_print
      print(f1);
      print("ok");

      f2 = double.parse(dim[1].trim());
      print(f2);

      f3 = double.parse(dim[2].trim());
      print(f3);
    } catch (e) {}

    final val = f1 * f2 * f3 / dimFactor;

    return val;
  }

  static double findFinalWeight(double itemWeight, double dimensionalWeight) {
    double finalWeight = 0.0;

    if (itemWeight > dimensionalWeight) {
      finalWeight = itemWeight;
    } else if (itemWeight < dimensionalWeight) {
      finalWeight = dimensionalWeight;
    }
    return finalWeight;
  }

  static double totalShippingCost(double finalWeight) =>
      finalWeight * shipCostPound;

  static double totalCustomCost(double itemPrice) => itemPrice * customCost;

  static double totalMarkaFeeCost(double itemPrice) => itemPrice * markaFee;
}
