import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/http/http_constants.dart';
import 'package:flutter_wanandroid/http/http_manager.dart';

class MePage extends StatefulWidget {
  @override
  _BodyViewState createState() => new _BodyViewState();
}

class _BodyViewState extends State<MePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    _userInfo();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    print("dispose");
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("didChangeAppLifecycleState");
    if (state == AppLifecycleState.resumed) {
      _userInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: new Text(
          "个人中心",
        ),
      ),
      body: Container(
        child: ElevatedButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.all(15.0)),
              backgroundColor:
              MaterialStateProperty.all(Theme
                  .of(context)
                  .primaryColor),
              foregroundColor: MaterialStateProperty.all(Colors.white)),
          child: Text("登录"),
          onPressed: () {
            Navigator.of(context).pushNamed('/login').then((value) {
              _userInfo();
            });
          },
        ),
      ),
    );
  }

  void _userInfo() {
    HttpManager.instance.dio
        .get(HttpConstants.userinfo)
        .then((value) => {print(value)});
  }
}
