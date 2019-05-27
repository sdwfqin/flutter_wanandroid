import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/home/home_page.dart';
import 'package:flutter_wanandroid/me/me_page.dart';
import 'package:flutter_wanandroid/project/project_page.dart';
import 'package:flutter_wanandroid/tree/tree_page.dart';

/// Created with Android Studio.
/// User: 张钦
/// Date: 2018-11-01
/// email: sdwfqin@gmail.com
/// target:
class IndexPage extends StatefulWidget {
  @override
  State createState() {
    return _IndexState();
  }
}

class _IndexState extends State<IndexPage> {

  int _currentIndex = 0;
  List<BottomNavigationBarItem> _navigationViews;
  var _itemTitle = ['首页', '体系', '项目', '我的'];
  var _body;

  @override
  void initState() {
    super.initState();
    /// icon https://material.io/tools/icons
    _navigationViews = <BottomNavigationBarItem>[
      new BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: new Text(_itemTitle[0]),
      ),
      new BottomNavigationBarItem(
        icon: Icon(Icons.dashboard),
        title: new Text(_itemTitle[1]),
      ),
      new BottomNavigationBarItem(
        icon: Icon(Icons.widgets),
        title: new Text(_itemTitle[2]),
      ),
      new BottomNavigationBarItem(
        icon: Icon(Icons.person),
        title: new Text(_itemTitle[3]),
      ),
    ];
  }

  /// 初始化页面
  initData() {
    /// IndexedStack继承自Stack，它的作用是显示第index个child，其他child都是不可见的。
    /// https://www.colabug.com/4066700.html
    _body = new IndexedStack(
      index: _currentIndex,
      children: <Widget>[new HomePage(), new TreePage(), new ProjectPage(), new MePage()],
    );
  }

  @override
  Widget build(BuildContext context) {

    initData();

    return new Scaffold(
      body: _body,
      bottomNavigationBar: new BottomNavigationBar(
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
