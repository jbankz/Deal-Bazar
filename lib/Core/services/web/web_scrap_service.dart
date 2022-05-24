import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:deal_bazaar/core/others/response_status.dart';
import 'package:deal_bazaar/core/services/web/custom_exception.dart';
import 'package:deal_bazaar/UI/base_view/base_view.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;

import '../../../core/enums/process_status.dart';


class WebScrapService {
  static const _path =
      'https://api.proxycrawl.com/?token=FvDuXxv8GZYgDxQ0eJi-Zw&scraper=amazon-product-details&format=json&url=';
  static Future<void> makeRequestToDiffBot({required String url}) async {
    try {
      var client = http.Client();
      final encoded = Uri.encodeComponent(url);
      await client
          .get(
        Uri.parse(
          '$_path$encoded',
        ),
      )
          .then((value) {
        // log(value.body);
        log(value.statusCode.toString());

        if (value.statusCode == 200) {
          final data = jsonDecode(value.body);
          if (data['body']['name'] == null) {
            log('Empty');
          } else {
            final prod = ProductModel.fromJson(data);
            // log(prod.isAvailable.toString());
            log(prod.toString());
          }
        } else {
          throw CustomException(
            errorCode: value.statusCode,
          );
        }
      });
    } on CustomException catch (v) {
      log('Please select product only');
      log(v.errorCode.toString());
    } on SocketException {
      log('No Internet connection 😑');
    } on HttpException {
      log("Couldn't find the post 😱");
    } on FormatException {
      log("Bad response format 👎");
    }
  }

  static Future<ResponseStatus> getProductDetails({required String url}) async {
    print(url);
    ResponseStatus status =
        ResponseStatus(status: ProcessStatus.loading, value: {});

    try {
      var client = http.Client();

      final encoded = Uri.encodeComponent(url);

      print("parsing");
      await client
          .get(
        Uri.parse(
          '$_path$encoded',
        ),
      )
          .then((value) {
        print("parsed");

        if (value.statusCode == 200) {
          print("this is response");

          final data = jsonDecode(value.body);
          print(data);
          if (data['body']['name'] == null) {
            status.value = {
              'code': value.statusCode.toString(),
              'error': 'Not a  Product',
            };
            status.status = ProcessStatus.failed;
          } else {
            final prod = ProductModel.fromJson(data);
            status.value = {
              'code': value.statusCode.toString(),
              'data': prod,
            };
            status.status = ProcessStatus.compeleted;
          }
        } else {
          throw CustomException(
            errorCode: value.statusCode,
          );
        }
      });
    } on CustomException catch (v) {
      log('Please select product only');

      if (v.errorCode == 400) {
        status.value = {
          'code': v.errorCode.toString(),
          'error': 'Not a Product, Please go to a product details page',
        };
        status.status = ProcessStatus.failed;
      } else {
        status.value = {
          'code': v.errorCode.toString(),
          'error': 'Server Error, Please Try Again',
        };
        status.status = ProcessStatus.failed;
      }
      log(v.errorCode.toString());
    } on SocketException {
      log('No Internet connection 😑');
      status.value = {
        'code': '12002',
        'error': 'No Internet Available, Please Try Again',
      };
      status.status = ProcessStatus.failed;
    } on HttpException {
      log("Couldn't find the post 😱");
      status.value = {
        'code': '403',
        'error': 'Server Error, Please Try Again',
      };
      status.status = ProcessStatus.failed;
    } on FormatException {
      log("Bad response format 👎");
      status.value = {
        'code': '500',
        'error': 'Server Error, Please Try Again',
      };
      status.status = ProcessStatus.failed;
    } on Exception {}
    return status;
  }
}
