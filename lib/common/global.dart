import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/constants/sp_constants.dart';
import 'package:flutter_wanandroid/http/http_manager.dart';
import 'package:flutter_wanandroid/utils/sp_utils.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Created with Android Studio.
/// User: 张钦
/// Date: 4/2/21
/// email: sdwfqin@gmail.com
/// target: 全局配置
class Global {
  static late SharedPreferences prefs;

  static ThemeMode theme = ThemeMode.light;

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    prefs = await SharedPreferences.getInstance();

    String themeValue = await SpUtils.instance.getStorage(SpConstants.skin);
    theme = themeStringToThemeMode(themeValue);

    //初始化网络请求相关配置
    HttpManager();
  }
}
