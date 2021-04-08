import 'package:dio/dio.dart';
import 'package:flutter_wanandroid/http/http_manager.dart';

/// 登录
Future login(String username, String password) {
  var formData = FormData.fromMap({
    'username': username,
    'password': password,
  });
  return HttpManager.instance.dio.post("user/login", data: formData);
}

/// 用户信息
Future userInfo([bool ignoreException = false]) {
  return HttpManager.instance.dio.get("lg/coin/userinfo/json",
      options: Options(extra: {HttpManager.ignoreException: ignoreException}));
}
