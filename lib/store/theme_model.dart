import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/global.dart';

/// Created with Android Studio.
/// User: 张钦
/// Date: 4/2/21
/// email: sdwfqin@gmail.com
/// target: APP主题状态
class ThemeModel extends ChangeNotifier {

  // 获取当前主题，如果为设置主题，则默认使用浅色模式
  ThemeMode get theme => Global.theme;

  // 主题改变后，通知其依赖项，新主题会立即生效
  set theme(ThemeMode themeMode) {
    if (themeMode != theme) {
      Global.theme = themeMode;
      notifyListeners();
    }
  }
}