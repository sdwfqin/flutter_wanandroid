import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/index/index_page.dart';
import 'package:flutter_wanandroid/index/splash_page.dart';

void main() => runApp(new WanAndroid());

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
