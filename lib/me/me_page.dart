import 'package:flutter/material.dart';

class MePage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "个人中心",
        ),
      ),
      body: Container(
        child: new Text("个人中心"),
      ),
    );
  }
}
