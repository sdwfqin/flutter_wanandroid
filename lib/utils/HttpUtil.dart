import 'package:dio/dio.dart';

/// 描述：网络请求工具类
///
/// @author 张钦
/// @date 2018/12/6
class HttpUtil {
  static HttpUtil instance;

  Dio dio;
  Options options;

  static HttpUtil getInstance() {
    if (instance == null) {
      instance = new HttpUtil();
    }
    return instance;
  }

  HttpUtil() {
    // 或者通过传递一个 `options`来创建dio实例
    options = Options(
      // 请求基地址,可以包含子路径，如: "https://www.google.com/api/".
      baseUrl: "http://www.wanandroid.com/",
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 10000,

      ///  响应流上前后两次接受到数据的间隔，单位为毫秒。如果两次间隔超过[receiveTimeout]，
      ///  [Dio] 将会抛出一个[DioErrorType.RECEIVE_TIMEOUT]的异常.
      ///  注意: 这并不是接收数据的总时限.
      receiveTimeout: 3000,
      headers: {},
    );
    dio = new Dio(options);
    dio.interceptor.request.onSend = (Options options) {
      // 在请求被发送之前做一些事情
      print('发送成功 ====================');
      print('发送成功【headers】${options.headers}');
      print('发送成功【data】${options.data}');
      print('发送成功【baseUrl】${options.baseUrl}');
      print('发送成功【path】${options.path}');
      print('发送成功 ====================');
      return options; //continue
      // 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`对象或返回`dio.resolve(data)`。
      // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义数据data.
      //
      // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象，或返回`dio.reject(errMsg)`，
      // 这样请求将被中止并触发异常，上层catchError会被调用。
    };
    dio.interceptor.response.onSuccess = (Response response) {
      // 在返回响应数据之前做一些预处理
      print('请求成功 ====================');
      print('请求成功【statusCode】${response.statusCode}');
      print('请求成功【headers】${response.headers}');
      print('请求成功【data】${response.data}');
      print('请求成功 ====================');
      return response; // continue
    };
    dio.interceptor.response.onError = (DioError e) {
      // 当请求失败时做一些预处理
      print('请求失败${e.toString()}');
      return e; //continue
    };
  }

  get(url, {data, options, cancelToken}) async {
    Response response;
    try {
      response = await dio.get(
        url,
        data: data,
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
