import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'api_constants.dart';

enum Method { post, get, put, delete, patch }

class RestClient extends GetxService {
  late Dio _dio;

  //this is for header
  static header() => {
    'Content-Type': 'application/json',
  };

  Future<RestClient> init() async {
    _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl, headers: header()));
    initInterceptors();
    return this;
  }

  void initInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      log('REQUEST[${options.method}] => PATH: ${options.path} '
          '=> Request Values: ${options.queryParameters}, => HEADERS: ${options.headers}');
      return handler.next(options);
    }, onResponse: (response, handler) {
      log('RESPONSE[${response.statusCode}] => DATA: ${response.data}');
      return handler.next(response);
    }, onError: (err, handler) {
      log('ERROR[${err.response?.statusCode}]');
      return handler.next(err);
    }));
  }

  Future<dynamic> request(
      String url, Method method, Map<String, dynamic>? params) async {
    init();
    Response response;

    try {
      if (method == Method.post) {
        response = await _dio.post(url, data: params);
      } else if (method == Method.delete) {
        response = await _dio.delete(url);
      } else if (method == Method.patch) {
        response = await _dio.patch(url);
      } else {
        response = await _dio.get(
          url,
          queryParameters: params,
        );
      }

      if (response.statusCode == 200) {

        return response;
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else if (response.statusCode == 500) {
        throw Exception("Server Error");
      } else {
        throw Exception("Something Went Wrong");
      }
    } on SocketException {
      throw Exception("No Internet Connection");
    } on FormatException {
      throw Exception("Bad Response Format!");
    } on DioError catch (e){
      throw Exception(e);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}