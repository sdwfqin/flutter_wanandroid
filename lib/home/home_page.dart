import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
