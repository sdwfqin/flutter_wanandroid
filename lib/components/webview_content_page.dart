import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/utils/loading_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Created with Android Studio.
/// User: 张钦
/// Date: 2019-05-29
/// email: sdwfqin@gmail.com
/// target: WebView
class WebViewContentPage extends StatefulWidget {
  final String title;
  final String url;

  WebViewContentPage(this.title, this.url);

  @override
  _WebViewContentPageState createState() =>
      new _WebViewContentPageState(title, url);
}

class _WebViewContentPageState extends State<WebViewContentPage> {
  final String title;
  final String url;

  LoadingUtils _loadingUtils = LoadingUtils();

  _WebViewContentPageState(this.title, this.url);

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    Future.delayed(Duration.zero, () {
      _loadingUtils.showLoading(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          title,
        ),
      ),
      body: WebView(
        initialUrl: url,
        onPageFinished: (url) {
          _loadingUtils.hideLoading();
        },
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
