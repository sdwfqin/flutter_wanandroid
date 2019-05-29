import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/components/progress_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Created with Android Studio.
/// User: 张钦
/// Date: 2019-05-29
/// email: sdwfqin@gmail.com
/// target: WebView
class WebViewPage extends StatefulWidget {
  final String title;
  final String url;

  WebViewPage(this.title, this.url);

  @override
  _WebViewPageState createState() => new _WebViewPageState(title, url);
}

class _WebViewPageState extends State<WebViewPage> {
  final String title;
  final String url;
  bool loading = true;

  _WebViewPageState(this.title, this.url);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          title,
        ),
      ),
      body: ProgressDialog(
        // 第一次进入有动画
        loading: loading,
        msg: "正在加载中",
        alpha: 0,
        child: WebView(
          initialUrl: url,
          onPageFinished: (url) {
            setState(() {
              loading = false;
            });
          },
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
