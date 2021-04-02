import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wanandroid/pages/index/index_page.dart';
import 'package:flutter_wanandroid/pages/index/splash_page.dart';
import 'package:flutter_wanandroid/pages/login/login_page.dart';
import 'package:flutter_wanandroid/pages/system/setting_page.dart';
import 'package:flutter_wanandroid/store/theme_model.dart';
import 'package:provider/provider.dart';

import 'common/global.dart';

void main() {
  //顶部状态栏透明
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  Global.init().then((e) => runApp(
        MultiProvider(
            providers: [ListenableProvider<ThemeModel>(create: (_) => ThemeModel())],
            builder: (context, child) {
              return WanAndroid();
            }),
      ));
}

/// Created with Android Studio.
/// User: 张钦
/// Date: 2018-11-01
/// email: sdwfqin@gmail.com
/// target:
class WanAndroid extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      theme: ThemeData(
        brightness: Brightness.light,
        // scaffoldBackgroundColor: Color(0xFFF5F5F9),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        // scaffoldBackgroundColor: Color(0xFFF5F5F9),
      ),
      themeMode: context.watch<ThemeModel>().theme,
      routes: {
        '/': (context) => SplashPage(),
        '/index': (context) => IndexPage(),
        '/login': (context) => LoginPage(),
        '/setting': (context) => SettingPage(),
      },
      title: '玩Android-Flutter版',
    );
  }
}
