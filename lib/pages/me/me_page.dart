import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/constants/sp_constants.dart';
import 'package:flutter_wanandroid/http/api/user.dart';
import 'package:flutter_wanandroid/utils/sp_utils.dart';

/// Created with Android Studio.
/// User: 张钦
/// Date: 4/2/21
/// email: sdwfqin@gmail.com
/// target: 个人中心
class MePage extends StatefulWidget {
  @override
  _BodyViewState createState() => new _BodyViewState();
}

class _BodyViewState extends State<MePage> with WidgetsBindingObserver {
  var _userData = Map();

  @override
  void initState() {
    super.initState();
    _initData();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _initData();
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
      body: Column(
        children: [
          GestureDetector(
            child: Container(
              color: Theme.of(context).cardColor,
              height: 100,
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    foregroundImage: NetworkImage(
                        'https://avatars.githubusercontent.com/u/13191807?v=4'),
                    // backgroundImage: ExactAssetImage('images/logo.png'),
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    radius: 35.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(_userData["nickname"] ?? "请登录",
                                  style: Theme.of(context).textTheme.subtitle1),
                            ],
                          ),
                          Row(
                            children: [
                              Text("等级：",
                                  style: Theme.of(context).textTheme.bodyText2),
                              Expanded(
                                flex: 1,
                                child: Text(
                                    (_userData["level"] ?? "").toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text("积分：",
                                  style: Theme.of(context).textTheme.bodyText2),
                              Expanded(
                                flex: 1,
                                child: Text(_userData["rank"] ?? "",
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              _headerClick();
            },
          ),
          Container(
            height: 15.0,
          ),
          Divider(
            height: 1.0,
          ),
          Ink(
            color: Theme.of(context).cardColor,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/setting');
              },
              child: Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 15, right: 10),
                  child: Row(
                    children: [
                      Icon(Icons.settings, color: Theme.of(context).hintColor),
                      Container(width: 10),
                      Text("设置", style: Theme.of(context).textTheme.bodyText1),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Icon(Icons.chevron_right,
                          color: Theme.of(context).hintColor)
                    ],
                  )),
            ),
          ),
          Divider(
            height: 1.0,
          ),
          Ink(
            color: Theme.of(context).cardColor,
            child: InkWell(
              onTap: () {},
              child: Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 15, right: 10),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline,
                          color: Theme.of(context).hintColor),
                      Container(width: 10),
                      Text("关于", style: Theme.of(context).textTheme.bodyText1),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Icon(Icons.chevron_right,
                          color: Theme.of(context).hintColor)
                    ],
                  )),
            ),
          ),
          Divider(
            height: 1.0,
          ),
        ],
      ),
    );
  }

  void _initData() {
    userInfo(true).then((value) {
      setState(() {
        _userData.addAll(value.data["data"]);
      });
      SpUtils.instance.getStorage(SpConstants.userData).then((value) {
        setState(() {
          _userData.addAll(value);
        });
      });
    });
  }

  void _headerClick() {
    Navigator.of(context).pushNamed('/login').then((value) {
      _initData();
    });
  }
}
