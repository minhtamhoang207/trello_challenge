import 'package:get/get_connect/connect.dart';
import 'package:trello_challenge/app/data/api/interceptor/auth_interceptor.dart';

import 'api_constants.dart';
import 'interceptor/request_interceptor.dart';
import 'interceptor/response_interceptor.dart';

class BaseProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = ApiConstants.baseUrl;
    httpClient.addAuthenticator(authInterceptor);
    httpClient.addRequestModifier(requestInterceptor);
    httpClient.addResponseModifier(responseInterceptor);
  }
}