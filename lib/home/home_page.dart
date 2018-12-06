import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/utils/HttpUtil.dart';

class HomePage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    HttpUtil().get("article/list/0/json");
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "首页",
        ),
      ),
      body: Container(
        child: new Text("首页"),
      ),
    );
  }
}
