import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/pages/home/home_page.dart';
import 'package:flutter_wanandroid/pages/me/me_page.dart';
import 'package:flutter_wanandroid/pages/project/project_page.dart';
import 'package:flutter_wanandroid/pages/tree/tree_page.dart';

/// Created with Android Studio.
/// User: 张钦
/// Date: 2018-11-01
/// email: sdwfqin@gmail.com
/// target:
class IndexPage extends StatefulWidget {
  @override
  State createState() => _IndexState();
}

class _IndexState extends State<IndexPage> {
  int _currentIndex = 0;
  late List<BottomNavigationBarItem> _navigationViews;
  var _itemTitle = ['首页', '体系', '项目', '我的'];
  var _body;

  @override
  void initState() {
    super.initState();

    /// icon https://material.io/tools/icons
    _navigationViews = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: _itemTitle[0],
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.dashboard),
        label: _itemTitle[1],
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.widgets),
        label: _itemTitle[2],
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: _itemTitle[3],
      ),
    ];
  }

  /// 初始化页面
  initData() {
    /// IndexedStack继承自Stack，它的作用是显示第index个child，其他child都是不可见的。
    /// https://www.colabug.com/4066700.html
    /// 也可以使用PageView
    _body = Container(
        child: IndexedStack(index: _currentIndex, children: <Widget>[
      HomePage(),
      TreePage(),
      ProjectPage(),
      MePage()
    ]));
  }

  @override
  Widget build(BuildContext context) {
    initData();

    return Scaffold(
      body: _body,
      bottomNavigationBar: BottomNavigationBar(
        items: _navigationViews
            .map((BottomNavigationBarItem navigationView) => navigationView)
            .toList(),
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
