import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/index/index_page.dart';
import 'package:flutter_wanandroid/index/splash_page.dart';

void main() => runApp(new WanAndroid());

/// Created with Android Studio.
/// User: 张钦
/// Date: 2018-11-01
/// email: sdwfqin@gmail.com
/// target:
class WanAndroid extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/index': (context) => IndexPage(),
      },
      title: '玩Android',
    );
  }
}
