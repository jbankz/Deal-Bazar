import 'package:deal_bazaar/Core/Constants/logger.dart';
import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import '../general_webview.dart';
import 'package:html/parser.dart' as parser;

class WebViewAmazon extends StatefulWidget {
  final String? url;
  const WebViewAmazon({this.url, Key? key}) : super(key: key);

  @override
  State<WebViewAmazon> createState() => _WebViewAmazonState();
}

class _WebViewAmazonState extends State<WebViewAmazon> {
  double _price = 0;

  @override
  Widget build(BuildContext context) {
    return GeneralWebView(
      url: widget.url,
      price: _price,
      handleGetPriceFunction: (String url) => _handleFunction(url),
    );
  }

  void makeRequest() async {
    logger.d('message');
    var response = await http.get(Uri.parse(
        'https://www.amazon.com/Apple-13-Pro-Max-Graphite/dp/B09LPK77YY/?_encoding=UTF8&pf_rd_p=d27b498c-b40a-4a36-92cf-b0aafa3ba1ce&pd_rd_wg=fqkof&pf_rd_r=6JYGCR5X9D2FS8NQHSWZ&pd_rd_w=6DVIa&pd_rd_r=328d276e-87f6-422b-8452-963c79d74c79&ref_=ci_mcx_mr_hp_atf_m'));
    //If the http request is successful the statusCode will be 200
    if (response.statusCode == 200) {
      String htmlToParse = response.body;

      final webScraper = WebScraper('https://www.amazon.com/');

      if (await webScraper.loadWebPage(
          'Apple-13-Pro-Max-Graphite/dp/B09LPK77YY/?_encoding=UTF8&pf_rd_p=d27b498c-b40a-4a36-92cf-b0aafa3ba1ce&pd_rd_wg=fqkof&pf_rd_r=6JYGCR5X9D2FS8NQHSWZ&pd_rd_w=6DVIa&pd_rd_r=328d276e-87f6-422b-8452-963c79d74c79&ref_=ci_mcx_mr_hp_atf_m')) {}
      dom.Document document = parser.parse(htmlToParse);

      final _element = document.getElementsByClassName(
          'span.a-price.a-text-price.a-size-medium.apexPriceToPay');
      _element.map((e) {
        final _data = e.getElementsByTagName('span')[0].innerHtml;
        logger.d(_data);
      }).toList();
    }
  }

  void _handleFunction(String value) async {
    makeRequest();
    /*  final endpoint = value.replaceAll(r'https://www.amazon.com', '');

    logger.d(value);

    final webScraper = WebScraper('https://www.amazon.com');

    try {
      if (await webScraper.loadWebPage(endpoint)) {
        var val = webScraper.getElement(
            'span.a-price.a-text-price.a-size-medium.apexPriceToPay',
            ['innerHtml']).first['title'];

        var arr = val.split('\$');

        setState(() {
          Navigator.pop(context);
          logger.d(arr.last);
          // _price = double.parse(arr.last);
        });
      }
    } on WebScraperException catch (e) {
      logger.d(e.errorMessage());
    } catch (e) {
      logger.e(e);
    } */
  }
}
