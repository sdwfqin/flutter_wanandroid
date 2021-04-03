import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_wanandroid/utils/toast_utils.dart';
import 'package:path_provider/path_provider.dart';

/// 描述：网络请求工具类
///
/// @author 张钦
/// @date 2018/12/6
class HttpManager {

  static final String ignoreException = "ignoreException";

  // 单例模式
  static final HttpManager instance = HttpManager._internal();

  factory HttpManager() => instance;

  HttpManager._internal() {
    init();
  }

  Dio get dio => _dio;

  late Dio _dio;

  init() {
    // 或者通过传递一个 `options`来创建dio实例
    BaseOptions options = BaseOptions(
      // 请求基地址,可以包含子路径，如: "https://www.google.com/api/".
      baseUrl: "https://www.wanandroid.com/",
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 10000,

      ///  响应流上前后两次接受到数据的间隔，单位为毫秒。如果两次间隔超过[receiveTimeout]，
      ///  [Dio] 将会抛出一个[DioErrorType.RECEIVE_TIMEOUT]的异常.
      ///  注意: 这并不是接收数据的总时限.
      receiveTimeout: 3000,
      headers: {},
    );
    _dio = new Dio(options);
    _getLocalFile();
    // 打印日志
    _dio.interceptors.add(LogInterceptor(responseBody: true));
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      // Do something before request is sent
      return handler.next(options); //continue
    }, onResponse: (response, handler) {
      // 忽略全局异常处理，仍然可以单独处理异常
      var extraIgnoreException = response.requestOptions.extra[ignoreException];
      if(extraIgnoreException != null && extraIgnoreException){
        return handler.next(response); // continue
      }
      if (response.data['errorCode'] != 0) {
        return handler.reject(
            DioError(
                requestOptions: response.requestOptions,
                error: response.data['errorMsg']),
            true);
      }
      return handler.next(response); // continue
    }, onError: (DioError e, handler) {
      // Do something with response error
      showToast(e.message);
      return handler.next(e); //continue
    }));
  }

  void _getLocalFile() async {
    // 获取文档目录的路径
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dir = appDocDir.path + "/.cookies/";
    print('cookie路径地址：' + dir);
    var cookieJar = PersistCookieJar(storage: FileStorage(dir));
    _dio.interceptors.add(CookieManager(cookieJar));
  }
}
