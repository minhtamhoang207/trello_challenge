import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

FutureOr<dynamic> responseInterceptor(Request request, Response response) async {

  if (response.statusCode != 200 && response.statusCode != 201) {
    log('''
    
Error:
status_code: ${response.statusCode}
body: ${response.body}''');
    handleErrorStatus(response);
    return;
  }
  log('''
  
Response:
status_code: ${response.statusCode}
body: ${response.body}''');
  return response;
}

void handleErrorStatus(Response response) {
  switch (response.statusCode) {
    case 400:
      throw response.body['message'];
    case 401:
      throw response.body;
    case 500:
    case 502:
      throw 'Máy chủ đã xảy ra lỗi vui vòng thử lại sau';
    default:
      throw 'Đã xảy ra lỗi vui lòng thử lại sau';
  }
}