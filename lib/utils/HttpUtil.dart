import 'package:dio/dio.dart';

/// 描述：网络请求工具类
///
/// @author 张钦
/// @date 2018/12/6
class HttpUtil {
  static HttpUtil instance;

  Dio dio;
  BaseOptions options;

  static HttpUtil getInstance() {
    if (instance == null) {
      instance = new HttpUtil();
    }
    return instance;
  }

  HttpUtil() {
    // 或者通过传递一个 `options`来创建dio实例
    options = BaseOptions(
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
    dio = new Dio(options);
    // 打印日志
    dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  get(url, {data, options, cancelToken}) async {
    Response response;
    try {
      response = await dio.get(
        url,
        queryParameters: data,
        cancelToken: cancelToken,
      );
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('get请求取消! ' + e.message);
      }
      print('get请求发生错误：$e');
    }
    return response.data;
  }

  post(url, {data, options, cancelToken}) async {
    Response response;
    try {
      response = await dio.post(
        url,
        data: data,
        cancelToken: cancelToken,
      );
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('post请求取消! ' + e.message);
      }
      print('post请求发生错误：$e');
    }
    return response.data;
  }
}
