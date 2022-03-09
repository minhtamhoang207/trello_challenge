import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

FutureOr<dynamic> responseInterceptor(Request request, Response response) async {

  if (response.statusCode != 200) {
    handleErrorStatus(response);
    return;
  }
  log('-------------');
  log(response.statusCode.toString());
  log('-------------');

  return response;
}

void handleErrorStatus(Response response) {
  switch (response.statusCode) {
    case 400:
      // final message = ErrorResponse.fromJson(response.body);
      // CommonWidget.toast(message.error);
      break;
    default:
  }

  return;
}