import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';

import '../general_webview.dart';

class WebViewSalks extends StatefulWidget {
  final String? url;
  const WebViewSalks({this.url, Key? key}) : super(key: key);

  @override
  State<WebViewSalks> createState() => _WebViewSalksState();
}

class _WebViewSalksState extends State<WebViewSalks> {
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
    final endpoint = value.replaceAll(widget.url!, '');

    final webScraper = WebScraper(widget.url);
    try {
      if (await webScraper.loadWebPage(endpoint)) {
        var val = webScraper.getElement(
                'span.formatted_sale_price.formatted_price.js-final-sale-price.bfx-price.bfx-list-price',
                ['innerHtml']).first['title'] ??
            0;
        val = val.replaceAll(r'$', '');

        setState(() {
          Navigator.pop(context);
          _price = double.parse(val);
        });
      }
    } catch (e) {}
  }
}
