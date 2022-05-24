import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';

import '../general_webview.dart';

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
    final endpoint = value.replaceAll(widget.url!, '');

    final webScraper = WebScraper(widget.url);
    try {
      if (await webScraper.loadWebPage(endpoint)) {
        var val = webScraper.getElement(
                'span.ada-link.productAmount', ['innerHtml']).first['title'] ??
            0;
        val = val.replaceAll(r'$', '');

        setState(() {
          Navigator.pop(context);
          _price = double.parse(val);
          setState(() {});
        });
      }
    } catch (e) {}
  }
}
