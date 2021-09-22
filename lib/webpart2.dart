import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class part2 extends StatelessWidget {
  part2({@required this.url});
  final url;

  final Completer<WebViewController> _controler= new Completer<WebViewController>();
  void web(WebViewController webviewcontroller)  {
    _controler.complete(webviewcontroller);
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: WebView(
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
            key: key ,

          ),
        )
    );
  }
}
