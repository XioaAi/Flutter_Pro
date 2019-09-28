import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Browser extends StatelessWidget {

  final Map argument;

  Browser(this.argument);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.argument['title']),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: this.argument['url'],
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
