import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trello_challenge/data/api/api_constants.dart';
import 'package:trello_challenge/shared/constants/storage.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

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
    _dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      final token =
          Get.find<SharedPreferences>().getString(StorageConstants.token);
      if (token != null) {
        options.headers.putIfAbsent('Authorization', () => 'Bearer $token');
      }
      log('REQUEST[${options.method}]'
          '\n*** PATH: ${options.uri} '
          '\n*** Request Values: ${options.queryParameters},'
          '\n*** Request data: ${options.data},'
          '\n*** Request params: ${options.queryParameters},'
          '\n*** HEADERS: ${options.headers}\n');
      return handler.next(options);
    },

    onResponse: (response, handler) {
      log('RESPONSE[${response.statusCode}] \n*** DATA: ${response.data}\n');
      return handler.next(response);
    },

    onError: (err, handler) {
      log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}\n');
      return handler.next(err);
    }));
  }

  Future<Response> request({
    required String url,
    required Method method,
    dynamic params}) async {
    late Response response;

    try {
      if (method == Method.POST) {
        response = await _dio.post(url, data: params);
      } else if (method == Method.DELETE) {
        response = await _dio.delete(url);
      } else if (method == Method.PATCH) {
        response = await _dio.patch(url);
      } else if (method == Method.PUT) {
        response = await _dio.put(url, data: params);
      } else {
        response = await _dio.get(
          url,
          queryParameters: params,
        );
      }
      return response;
    } on SocketException catch (e) {
      log(e.toString());
      throw 'Vui lòng kiểm tra lại kết nối mạng';
    } on FormatException {
      throw 'Bad request';
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        if (e.response?.statusCode == 404) {
          throw '404 NOT FOUND';
        }
      }
      if (e.type == DioErrorType.other) {
        log(e.toString());
        throw 'Vui lòng kiểm tra lại kết nối mạng';
      } else {
        throw e.response?.data['message'] ??
            'Đã xảy ra lỗi vui lòng thử lại sau';
      }
    } catch (e) {
      throw 'Đã xảy ra lỗi vui lòng thử lại sau';
    }
  }
}
