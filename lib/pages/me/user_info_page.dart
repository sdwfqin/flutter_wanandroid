import 'package:flutter/material.dart';

/// Created with Android Studio.
/// User: 张钦
/// Date: 4/15/21
/// email: sdwfqin@gmail.com
/// target: 用户信息
class UserInfoPage extends StatefulWidget {
  @override
  _BodyViewState createState() => new _BodyViewState();
}

class _BodyViewState extends State<UserInfoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          "个人中心",
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
