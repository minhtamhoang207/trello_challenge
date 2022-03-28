import 'dart:async';
import 'dart:developer';
import 'package:get/get_connect/http/src/request/request.dart';

FutureOr<Request> requestInterceptor(Request request) async {
  // final token = StorageService.box.pull(StorageItems.accessToken);
  //
  // request.headers['X-Requested-With'] = 'XMLHttpRequest';
  // request.headers['Authorization'] = 'Bearer $token';
  log('Method: ${request.method}');
  log('Header: ${request.headers}');
  log('Url: ${request.url}');
  return request;
}