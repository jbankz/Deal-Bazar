import 'package:deal_bazaar/Core/Constants/logger.dart';
import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';

import 'general_webview.dart';

class WebViewMichaelKors extends StatefulWidget {
  final String? url;
  const WebViewMichaelKors({this.url, Key? key}) : super(key: key);

  @override
  State<WebViewMichaelKors> createState() => _WebViewMichaelKorsState();
}

class _WebViewMichaelKorsState extends State<WebViewMichaelKors> {
  double _price = 0;

  @override
  Widget build(BuildContext context) {
    return GeneralWebView(
      url: widget.url,
      price: _price,
      handleGetPriceFunction: (String url) => _handleFunction(url),
    );
  }

  void _handleFunction(String value) async {
    final endpoint = value.replaceAll(r'https://www.michaelkors.com', '');

    final webScraper = WebScraper('https://www.michaelkors.global');
    print("scrped base url");

    logger.d("this is endpoint " + endpoint);

    try {
      if (await webScraper.loadWebPage(
          '/en_NG/marilyn-medium-saffiano-leather-tote-bag/_/R-30S2S6AT2L?color=0410')) {
        print("initialized array");
        var val = webScraper.getElement(
                'span.ada-link.productAmount', ['innerHtml']).first['title'] ??
            0;
        val = val.replaceAll(r'$', '');

        setState(() {
          print("this is price " + val.toString());
          Navigator.pop(context);
          _price = double.parse(val);
          // showBox(vm);
        });
      }
    } on WebScraperException catch (e) {
      logger.e('An error occurred => ${e.errorMessage()}');
      /*   setState(() {
          Navigator.pop(context);
          showErrorMessageDialog(
              errorText: "Not a product page", statusText: "400");
        }); */
    } catch (e) {
      logger.e('Caught Error: $e');
    }
  }
}
