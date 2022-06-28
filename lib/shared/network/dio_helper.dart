import 'package:dio/dio.dart';

class DioHelpper {
  static late Dio dio;
  static init() {
    dio = Dio();
    BaseOptions(
      baseUrl: "https://newsapi.org/",
      receiveDataWhenStatusError: false,
    );
  }

  static Future<Response> getData(
      {required String url, Map<String, dynamic>? query}) async {
    return await dio.get(
      url,
      queryParameters: query,
    );
  }
}

//==>v2/top-headlines
