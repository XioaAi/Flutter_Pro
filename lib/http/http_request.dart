import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/http/api.dart';
import 'package:flutter_app/http/result_data.dart';
import 'package:flutter_app/data/recommend_pro_entity.dart';
import 'dart:convert';
/*
//普通格式的header
Map<String, dynamic> headers = {
  "Accept":"application/json",
//  "Content-Type":"application/x-www-form-urlencoded",
};*/
//json格式的header
Map<String, dynamic> headersJson = {
  "Accept":"application/json",
  "Content-Type":"application/json; charset=UTF-8",
};

class HttpUtil {

  static final HttpUtil _instance = HttpUtil._init();
  static Dio _dio;
  static BaseOptions _options = getDefOptions(header: headersJson);

  factory HttpUtil() {
    return _instance;
  }

  HttpUtil._init() {
    _dio = new Dio();
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options){
          print("\n================== 请求数据 ==========================");
          print("url = ${options.uri.toString()}");
          print("headers = ${options.headers}");
          print("params = ${options.data}");
        },
        onResponse: (Response response){
          print("\n================== 响应数据 ==========================");
          print("code = ${response.statusCode}");
          print("data = ${response.data}");
          print("\n");
        },
        onError: (DioError e){
          print("\n================== 错误响应数据 ======================");
          print("type = ${e.type}");
          print("message = ${e.message}");
          print("stackTrace = ${e.stackTrace}");
          print("\n");
        }
    ));
    _dio.options = _options;
  }

  setOntions(Map<String, dynamic> header) {
    _options.headers = header;
  }

  static BaseOptions getDefOptions({Map<String, dynamic> header}) {
    _options = BaseOptions(
      // 请求基地址，一般为域名，可以包含路径
      baseUrl: Api.baseUrl,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 10000,
      //[如果返回数据是json(content-type)，dio默认会自动将数据转为json，无需再手动转](https://github.com/flutterchina/dio/issues/30)
      responseType:ResponseType.plain,
      ///  响应流上前后两次接受到数据的间隔，单位为毫秒。如果两次间隔超过[receiveTimeout]，
      ///  [Dio] 将会抛出一个[DioErrorType.RECEIVE_TIMEOUT]的异常.
      ///  注意: 这并不是接收数据的总时限.
      receiveTimeout: 3000,
      headers: header,
    );

    return _options;
  }

  get(url,successCallBack(Map<String, dynamic> map),{Function errorCallBack}) async {
    try {
      Response response = await _dio.get(url);
      Map<String, dynamic> map = json.decode(response.data);
      successCallBack(map);
    } on DioError catch (e) {
      handlingResult(error:e);
    }
  }

  post(url,Function successCallBack,{data,Function errorCallBack}) async {
    try {
      Response response = await _dio.post(
        url,
        data: data,
      );
      successCallBack(response.data);
    } on DioError catch (e) {
      handlingResult(error: e);
    }
  }

  handlingResult({DioError error,Function errorCallBack}){
    switch(error.type){
    //网络请求取消
      case DioErrorType.CANCEL:
        errorCallBack(-1,'网络请求取消');
        break;
    //网络连接超时
      case DioErrorType.CONNECT_TIMEOUT:
        errorCallBack(-2,'网络连接超时,请检查网络');
        // TODO: Handle this case.
        break;
    //网络发送数据超时
      case DioErrorType.SEND_TIMEOUT:
        errorCallBack(-3,'操作超时');
        // TODO: Handle this case.
        break;
    //网络接收数据超时
      case DioErrorType.RECEIVE_TIMEOUT:
        errorCallBack(-3,'操作超时');
        // TODO: Handle this case.
        break;
    //网络重定向  404  503
      case DioErrorType.RESPONSE:
        errorCallBack(-4,'接口错误');
        // TODO: Handle this case.
        break;
    //未知错误
      case DioErrorType.DEFAULT:
        errorCallBack(-5,'未知错误');
        // TODO: Handle this case.
        break;
    }
  }


}