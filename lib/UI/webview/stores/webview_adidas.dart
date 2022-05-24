import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';

import '../general_webview.dart';

class WebViewAdidas extends StatefulWidget {
  final String? url;
  const WebViewAdidas({this.url, Key? key}) : super(key: key);

  @override
  State<WebViewAdidas> createState() => _WebViewAdidasState();
}

class _WebViewAdidasState extends State<WebViewAdidas> {
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

    final webScraper = WebScraper(widget.url!);

    try {
      if (await webScraper.loadWebPage(endpoint)) {
        var val = webScraper.getElement('div.gl-price-item.notranslate',
                ['innerHtml']).first['title'] ??
            0;
        val = val.replaceAll(r'₹', '');
        val = val.replaceAll(r'$', '');

        setState(() {
          Navigator.pop(context);
          _price = double.parse(val);
        });
      }
    } catch (e) {}
  }
}
