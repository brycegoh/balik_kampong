import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../widgets/layout.dart';
import '../../widgets/default.dart';
import '../../utility/constants.dart';

class WebViewScreen extends StatefulWidget {
  final String? url;
  const WebViewScreen({Key? key, this.url}) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _controller;

  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kampongDefaultAppBar(),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: widget.url ?? 'https://brycegoh.me',
        onWebViewCreated: (WebViewController controller) {
          setState(() {
            _controller = controller;
          });
        },
      ),
    );
  }
}
