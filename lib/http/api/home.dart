import 'package:flutter_wanandroid/http/http_manager.dart';

/// 首页banner
Future homeBanner() {
  return HttpManager.instance.dio.get("banner/json");
}

/// 首页列表
Future homeList(int currentPager) {
  return HttpManager.instance.dio
      .get("article/list/$currentPager/json");
}
