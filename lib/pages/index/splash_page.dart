import 'dart:ui';

import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashState();
  }
}

class _SplashState extends State<SplashPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        child: Center(
          child: Image.asset(
            "images/splash.png",
            width: window.physicalSize.width,
            height: window.physicalSize.height,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }

  /// 初始化
  @override
  void initState() {
    super.initState();
    countDown();
  }

  /// 倒计时1秒
  void countDown() {
    var _duration = new Duration(seconds: 2);
    new Future.delayed(_duration, toIndexPage);
  }

  /// 跳转到主页
  void toIndexPage() {
    /// pushReplacementNamed 替换当前路径
    Navigator.of(context).pushReplacementNamed('/index');
  }
}
