import 'package:get/get.dart';

import '../base_provider.dart';

class AuthProvider extends BaseProvider {
  Future<Response> getUser(String path) {
    print(path);
    return get(path);
  }
  //
  // Future<Response> register(String path, RegisterRequest data) {
  //   return post(path, data.toJson());
  // }
  //
  // Future<Response> getUsers(String path) {
  //   return get(path);
  // }
}