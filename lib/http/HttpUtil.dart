import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';

/// 描述：网络请求工具类
///
/// @author 张钦
/// @date 2018/12/6
class HttpUtil {
  // 单例模式
  static final HttpUtil instance = HttpUtil._internal();

  factory HttpUtil() => instance;

  HttpUtil._internal() {
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
      // 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`,如`dio.resolve(response)`。
      // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
      //
      // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象,如`dio.reject(error)`，
      // 这样请求将被中止并触发异常，上层catchError会被调用。
    }, onResponse: (response, handler) {
      // Do something with response data
      if (response.data['errorCode'] != 0) {
        return handler.reject(DioError(
            requestOptions: response.requestOptions,
            error: response.data['errorMsg']));
      }
      return handler.next(response); // continue
      // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象,如`dio.reject(error)`，
      // 这样请求将被中止并触发异常，上层catchError会被调用。
    }, onError: (DioError e, handler) {
      // Do something with response error
      print(e);
      return handler.next(e); //continue
      // 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`,如`dio.resolve(response)`。
      // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
    }));
  }

  void _getLocalFile() async {
    // 获取文档目录的路径
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dir = appDocDir.path + "/.cookies/";
    print('cookie路径地址：' + dir);
    // TODO cookie这里有延时，刚进来获取不到
    var cookieJar = PersistCookieJar(storage: FileStorage(dir));
    _dio.interceptors.add(CookieManager(cookieJar));
  }
}
