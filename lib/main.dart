import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wanandroid/http/http_manager.dart';
import 'package:flutter_wanandroid/pages/index/index_page.dart';
import 'package:flutter_wanandroid/pages/index/splash_page.dart';
import 'package:flutter_wanandroid/pages/login/login_page.dart';

void main() {
  //顶部状态栏透明
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent)
  );
  runApp(WanAndroid());
}

/// Created with Android Studio.
/// User: 张钦
/// Date: 2018-11-01
/// email: sdwfqin@gmail.com
/// target:
class WanAndroid extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    HttpManager();
    return new MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/login': (context) => LoginPage(),
        '/index': (context) => IndexPage(),
      },
      title: '玩Android-Flutter版',
    );
  }
}
